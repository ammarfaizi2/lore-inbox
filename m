Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUHVHMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUHVHMc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 03:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUHVHMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 03:12:32 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:4775 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266324AbUHVHMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 03:12:30 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 10:12:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <4128457C.7090001@wasp.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSIFjE9KmKt8sXZTo2aSLaRKosmqwACJcoQ
Message-Id: <S266324AbUHVHMa/20040822071230Z+15@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel 2.4.18-14 [Redhat 8 standard installation] 

As I underlined, I have been able to disable IP header checksumming for the
received packets, so the system will not drop the packets even after CRC
becomes invalid when the source address changes.

I have been asking this question over ten different mailing list and forums
and no one has come up with a "solid" solution. I would be exteremely glad
if I get a working source code.

I know the application will be so very simple, just changing some bits with
another and putting it back to userspace, but it requires some low-level
libraries and the knowledge to use them... 

-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 9:04 AM
To: Josan Kadett
Cc: linux-kernel@vger.kernel.org
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

The main reason I suggested correcting the checksum is if it was done that
way, the kernel would 
behave normally for all other IP traffic and simply do a dodgy on only
traffic from 192.168.1.1

If nobody else jumps in, let me think about it for a day or so and I'll see
what I can do. It's been 
a couple of years since I last looked at the network code though.

What kernel are you running?

Regards,
Brad



