Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265113AbUEMVVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbUEMVVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265101AbUEMVVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:21:39 -0400
Received: from lionfish.bull.com ([141.112.4.90]:27093 "EHLO
	lionfish.az05.bull.com") by vger.kernel.org with ESMTP
	id S265100AbUEMVVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:21:35 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       linux-scsi-owner@vger.kernel.org
Subject: Re: [(re)Announce] Emulex LightPulse Device Driver
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF43CA8574.3A9C651D-ON07256E93.00714C91-07256E93.0075513F@az05.bull.com>
From: David.Egolf@Bull.com
Date: Thu, 13 May 2004 14:21:24 -0700
X-MIMETrack: Serialize by Router on US-PHX1/US/BULL(5012HF429 | October 14, 2003) at 05/13/2004
 02:21:25 PM,
	Serialize complete at 05/13/2004 02:21:25 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org>
Sent by: linux-scsi-owner@vger.kernel.org
05/09/2004 01:20 AM

>A bunch of comments from looking over the headers and itnerface to
>upper layers a little:  (next I'll try to understand what's going on
>in the I/O submission path - it's just to freakin complicated..):
>
> - the hba api crap must die
> o o o

The first bullet on your post is of interest to us.  We currently support 
customers with Emulex fc cards using a 2.4 kernel on IA64.  Our software 
employs the hba api supplied from Emulex in order determine the 
configuration of the SAN(s) connected to the cards.

Your comment is on the terse side.  Is your comment directed at this 
particular implementation of the hba api code, the current packaging 
situation, or do you have a general disregard for the hba api strategy? In 
short, do you believe that the hba api can and/or should be supported for 
the Emulex LightPulse Device Driver? 

-- David Egolf
