Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317253AbSIEMjr>; Thu, 5 Sep 2002 08:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSIEMjr>; Thu, 5 Sep 2002 08:39:47 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:47633 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S317253AbSIEMjq>; Thu, 5 Sep 2002 08:39:46 -0400
Date: Thu, 5 Sep 2002 20:43:36 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: remount reiserfs hangs under heavy load 2.4.20pre5
Message-ID: <Pine.LNX.4.42.0209052038310.31505-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/05/2002
 08:44:20 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/05/2002
 08:44:21 PM,
	Serialize complete at 09/05/2002 08:44:21 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Whenever "mount -o remount -n -w /dev/hdax" is issued under disk
activities, the system would freezed, and had to be hard booted.

All disk on reiserfs, so don't know whether this only applies to reiserfs
or ext2 as well.

Linux 2.4.20-pre5, but hangs too on 2.4.1x


Jeff.



