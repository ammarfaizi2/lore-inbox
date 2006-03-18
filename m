Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWCRXKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWCRXKo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWCRXKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:10:44 -0500
Received: from accolon.hansenpartnership.com ([64.109.89.108]:47060 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1751026AbWCRXKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:10:43 -0500
Subject: Re: [PATCH] fix potential return of uninitialized variable in
	scsi_scan   (resend)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Eric Youngdale <eric@andante.org>,
       linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200603182242.52507.jesper.juhl@gmail.com>
References: <200603182242.52507.jesper.juhl@gmail.com>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 17:10:33 -0600
Message-Id: <1142723433.3773.16.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 22:42 +0100, Jesper Juhl wrote:
> ( The patch below was already send on March 9, 2006. )
> ( This is a resend, re-diff'ed against 2.6.16-rc6    )
> 
> 
> The coverity checker found out that we potentially return sdev uninitialized.
> This should fix coverity #879

The fix for this is already in scsi-misc.

http://www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=a97a83a06b44d4d1cb01191423caf9813a150b95

James


