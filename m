Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTAVJ1X>; Wed, 22 Jan 2003 04:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTAVJ1X>; Wed, 22 Jan 2003 04:27:23 -0500
Received: from host-80-252-0-105.gazeta.pl ([80.252.0.105]:4772 "EHLO
	virgin.gazeta.pl") by vger.kernel.org with ESMTP id <S267411AbTAVJ1W>;
	Wed, 22 Jan 2003 04:27:22 -0500
Date: Wed, 22 Jan 2003 10:36:25 +0100
From: =?iso-8859-2?Q?Przemys=B3aw?= Maciuszko <sal@agora.pl>
To: linux-kernel@vger.kernel.org
Subject: Problem with Qlogic 2200 and 2.4.20
Message-ID: <20030122093625.GB2617@virgin.gazeta.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I have a strange problem with 2.4.20 (also 2.4.19) and Qlogic FC 2200.

The machine runs test news-server, so disk load is high.
After few minutes of running I get the following errors on console:

qlogifc0 : no handle slots, this should not happen
hostdata->queued is 19, in_ptr: 63
qlogifc0 : no handle slots, this should not happen
hostdata->queued is 19, in_ptr: 6a
qlogifc0 : no handle slots, this should not happen
hostdata->queued is 19, in_ptr: 70

and so on.

After this machine locks up completetly and hard reboot must be done.
When there is no load on disks machine runs fine for many hours.
I'm using stripped logical volume on disk connected through this Qlogic FC
(from IBM's Shark) and using ext3.
LVM version 1.0.6

-- 
Przemys³aw Maciuszko
Agora S.A.
