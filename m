Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275282AbTHGLGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275283AbTHGLGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:06:44 -0400
Received: from mail.gondor.com ([212.117.64.182]:19473 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S275282AbTHGLGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:06:42 -0400
Date: Thu, 7 Aug 2003 13:06:41 +0200
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030807110641.GA31809@gondor.com>
References: <20030806150335.GA5430@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806150335.GA5430@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 05:03:35PM +0200, Jan Niehusmann wrote:
> To summarize the problem: e2fsck reports block bitmap differences, but
> telling it to repair these doesn't help, another e2fsck run reports the
> same differences.

Now I pvmoved one PE which contains areas of the filesystem with errors
to a different drive. Surprise: e2fsck is now able to correct these
errors. Block bitmap differences in other PEs are still not fixed.

This strengthens my assumption that this is not a e2fsck problem, but
an LVM or IDE one.

Are there any known problems with huge hard disks (250GB) on Promise
IDE?

Jan

