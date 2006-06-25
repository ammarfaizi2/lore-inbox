Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWFYLso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWFYLso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWFYLso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:48:44 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:38607 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932397AbWFYLsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:48:43 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 25 Jun 2006 13:46:04 +0200
To: schilling@fokus.fraunhofer.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read atip wiith cdrecord
Message-ID: <449E777C.nail9X1595M9@burner>
References: <449E6B43.nail9A11I1BV@burner>
 <20060625040642.f37646ba.akpm@osdl.org>
In-Reply-To: <20060625040642.f37646ba.akpm@osdl.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> On Sun, 25 Jun 2006 12:53:55 +0200
> Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
>
> > The problem mentioned in this thread seems to be caused by the fact that
> > Linux sometimes ignores timeouts. I have no idea how to help in this (timeout) 
> > case.
>
> OK, thanks.  So is that likely to be an IDE bug, or a SCSI bug or an IDE-CD
> bug?

I am not sure if the log from the OP includes all information.

I've seen already messages like this:

cdrecord: Input/output error. Cannot set SG_SET_TIMEOUT.

This should be something that I would never to expect to happen.

If the OP does not see a similar message, it seems that the call is
accepted but later ignored. I have no idea why this happens.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
