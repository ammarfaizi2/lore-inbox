Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbVIUNUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbVIUNUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVIUNUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:20:16 -0400
Received: from Lodur.telex.com ([192.112.63.16]:6419 "EHLO lodur.telex.com")
	by vger.kernel.org with ESMTP id S1750892AbVIUNUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:20:15 -0400
To: linux-kernel@vger.kernel.org
Subject: 
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
From: Robert.Boermans@uk.telex.com
Message-ID: <OFC881AE81.2A41D9FD-ON80257083.00491CF1-80257083.00494354@telex.com>
Date: Wed, 21 Sep 2005 14:20:17 +0100
X-MIMETrack: Serialize by Router on Passthru01/Telex(652HF636|November 23, 2004) at 09/21/2005
 08:20:15 AM,
	Serialize complete at 09/21/2005 08:20:15 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I noticed that the bogomips results for the two cores on my machine are 
consistently not the same, the second one is always reported slightly 
faster, it's a small difference and I saw the same in a posted dmesg from 
somebody else on the list. Which made me wonder: 

Shouldn't they be the same, as the cores run from the same clock? 
Could it be a bug in the bogomips calculation which could make some of the 
short time-out stuff fail?
Could this be related to the tsc synchronisation stuff mentioned in the 
lost ticks - TSC timer thread? 

Regards, 

Robert Boermans. 
PS nothing actually fails on my system because of this, I just thought it 
was odd. Although I do sometimes get the clock runs at double speed 
problem but only after at least one day uptime, but I reboot most days for 
games anyway. 
