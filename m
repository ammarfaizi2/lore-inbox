Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030533AbWHIG0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbWHIG0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 02:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWHIG0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 02:26:45 -0400
Received: from mail.enyo.de ([212.9.189.167]:47521 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1030533AbWHIG0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 02:26:44 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Andy Davidson <andy@nosignal.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3ware 9550 using 3w-9xxx driver lockups ?
References: <44D89D5D.1000808@nosignal.org>
Date: Wed, 09 Aug 2006 07:29:43 +0200
In-Reply-To: <44D89D5D.1000808@nosignal.org> (Andy Davidson's message of "Tue,
	08 Aug 2006 15:19:09 +0100")
Message-ID: <8764h28ojc.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Davidson:

> Anyone else noticed any issues using the newer 3-ware 9550S cards with
> the 3w-9xxx driver ?

We've seen them as well, but tracked it down to a faulty drive.  You
should run smartctl against your drives and look for entries in the
error log.  (smartctl has speciall support for 3ware controllers, see
its manpage.)
