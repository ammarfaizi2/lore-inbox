Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWEVNFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWEVNFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWEVNFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:05:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:1907 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750801AbWEVNFG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:05:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=laQvu/WmTTOy5yPTTHnSt5TV7a/zwXjlGLyYDOo4G8NF3c4MwDxMw90CPK2vMMojaO7VoRzpKviKrG0ThRXY6/aSoS/Amh7SSd/SKZQD2is75h/QCcrWrHdRMP8XQEiskiaz2/eOMmSY5auiosxnRI0ebX5NObgamtnyPsDq5so=
Message-ID: <cf5433040605220605t22b6030j701add7d494c83e8@mail.gmail.com>
Date: Mon, 22 May 2006 13:05:05 +0000
From: "Rainer Shiz" <rainer.shiz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RAID Sync Speeds
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I have a general question on operating software RAIDs in linux.
    I am running md RAID in linux 2.6.12 kernel. I observed that the
sync speeds
were always much closer to /proc/sys/dev/raid/speed_limit_min value,
than
/proc/sys/dev/raid/speed_limit_max value. I agree that disk activity
(I/O) and
other system usage will bring down sync speeds. But I want sync speeds
to be
higher at whatever cost. So I thought I will just set max value to
around
500000 and leave the min at 5000. But with idle disk activity and
otherwise
idle system usage, I still see sync speeds around 5300Kb/s only.

So Is the 2.6 kernel designed to sync at speeds closer to min than max?

Please advise.

Please copy on your replies.

Thanks
