Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVE1N5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVE1N5o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 09:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVE1N5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 09:57:44 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:2703 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261591AbVE1N5m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 09:57:42 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: John Livingston <jujutama@comcast.net>
Subject: Re: How to find if BIOS has already enabled the device
Date: Sat, 28 May 2005 09:57:46 -0400
User-Agent: KMail/1.8
Cc: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       linux-kernel@vger.kernel.org
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com> <200505272150.15109.kernel-stuff@comcast.net> <4297E475.3040906@comcast.net>
In-Reply-To: <4297E475.3040906@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505280957.46853.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 23:24, John Livingston wrote:
> Also, is your BIOS fully up to date/modern?  A quick Google search found
> a few things like this:
> http://www.techspot.com/vb/all/windows/t-18940-USB-Hub-And-Boot-Problems.ht
>ml The problem might be more generic than a bad interaction between drive
> and kernel.
My BIOS is the latest version available from the laptop vendor. The laptop has 
some minor but peculiar issues - If I boot into Windows XP all works fine all 
the times (With USB HDD on during boot). If  I then restart the machine 
(without turning off) and boot into Linux - Linux doesn't detect my keyboard. 
I have power it off and reboot, only then it will detect the keyboard. So I 
wouldn't say the machine is 100% defect free but Windows has a way to work 
around it.

This current problem of Hang-On-Boot if USB drive is attached does not happen 
with Windows - so it is some sort of additional (unnecessary?) thing which 
Linux does and the BIOS doesn't like.  (Like re-enabling the controller even 
if BIOS has already enabled it or some such.)

Parag
