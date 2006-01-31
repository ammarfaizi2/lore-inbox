Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWAaBDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWAaBDP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 20:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWAaBDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 20:03:15 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7498 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965055AbWAaBDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 20:03:14 -0500
Date: Mon, 30 Jan 2006 19:01:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
In-reply-to: <5AKRr-4V5-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43DEB6FF.1020505@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5zENZ-72l-47@gated-at.bofh.it> <5AiBB-5AH-17@gated-at.bofh.it>
 <5AiV2-62l-7@gated-at.bofh.it> <5AJ9s-2go-23@gated-at.bofh.it>
 <5AKHI-4IV-5@gated-at.bofh.it> <5AKRr-4V5-19@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> There is no such bug in libscg.
> 
> There is nothing that has been freezed. 
> 
> If you have the apropriate privs to send SCSI commands to any SCSI device 
> on the system, you will not come across your problem.
> 
> Now let us try to talk about real problems or stop this discussion.

It appears that you are wanting to blame all of these problems on Linux 
and refuse to accept the possibility that cdrecord/libscg is doing 
things incorrectly from a Linux perspective. If you want to "talk about 
real problems" you must accept this possibility.

Why should I have to give privileges to send SCSI commands to any device 
  in the system just to write CDs? The answer, it would appear, is that 
cdrecord is messing with things (i.e. /dev/sg interface) it has no 
business messing with in current Linux systems, since that interface 
should not be necessary for the purpose of cdrecord.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

