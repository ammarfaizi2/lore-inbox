Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270024AbUJEQp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270024AbUJEQp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270193AbUJEQo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:44:58 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:42956 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270128AbUJEQiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:38:22 -0400
Subject: Re: Core scsi layer crashes in 2.6.8.1
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Mark Lord <lsml@rtr.ca>, Anton Blanchard <anton@samba.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <200410051826.11892.oliver@neukum.org>
References: <1096401785.13936.5.camel@localhost.localdomain>
	<200410051801.03677.oliver@neukum.org> <1096992458.2173.35.camel@mulgrave> 
	<200410051826.11892.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Oct 2004 11:38:11 -0500
Message-Id: <1096994297.2173.50.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 11:26, Oliver Neukum wrote:
> > b) The scsi bus is a scanned model ... drivers must be prepared to
> > accept commands for non-existent devices. How does the removal case
> > differ from the never present case?
> 
> It doesn't. But that doesn't explain why you want to issue the command
> in all cases, even if we coule easily tell you whether it makes sense or
> not? It makes no sense to me to throw away information you already have.

I'm lazy ... I don't see any point in going to a huge engineering effort
to avoid behaviour that the driver must cope correctly with anyway.  If
it isn't broken, don't fix it.

James


