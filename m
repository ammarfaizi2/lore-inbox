Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275309AbTHGM1i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275310AbTHGM1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:27:38 -0400
Received: from mail.gondor.com ([212.117.64.182]:43793 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S275309AbTHGM1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:27:37 -0400
Date: Thu, 7 Aug 2003 14:27:36 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: LBA48 on Promise 20265
Message-ID: <20030807122736.GA32523@gondor.com>
References: <20030806150335.GA5430@gondor.com> <20030807110641.GA31809@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807110641.GA31809@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 01:06:41PM +0200, Jan Niehusmann wrote:
> Are there any known problems with huge hard disks (250GB) on Promise
> IDE?

Further investigating this, I found the following posting:
http://lkml.org/lkml/2002/9/6/22

And indeed, even with 2.4.21, /proc/ide/ide2/hdf/settings shows that
'address' is 0, meaning that LBA48 is turned of, if I understand this
correctly. But that would mean that a 250GB hard disk should not work as
expected, right? May that explain my disk corruption problems?

Jan

