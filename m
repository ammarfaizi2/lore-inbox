Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTCBUpF>; Sun, 2 Mar 2003 15:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTCBUpF>; Sun, 2 Mar 2003 15:45:05 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:51424 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262812AbTCBUpE> convert rfc822-to-8bit; Sun, 2 Mar 2003 15:45:04 -0500
Message-ID: <3E626FB7.3030909@folkwang-hochschule.de>
Date: Sun, 02 Mar 2003 21:55:19 +0100
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: nettings@folkwang-hochschule.de
Subject: 2.5.60-63 panic: unable to mount root
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello everyone !

the kernel barfs and tells me to supply a root= kernel param.
i tried root=/dev/sda2, but no luck.

hw is all-scsi p2b-ds w/ dual p3/600.
boot is ext2, root (/dev/sda2) is reiserfs.
i'm using the new aic7xxx driver, the old driver one hangs at the same 
time, but continues to spit out a ton of error msgs i haven't bothered 
to capture, since i'm told it's deprecated.

the aic7xxx as well as ext2 and reiserfs are compiled into the kernel.
i'm not using devfs.

the system boots fine with 2.4.20.

google spit out these somewhat related threads, but they petered out 
without a solution.
www.uwsg.iu.edu/hypermail/linux/ kernel/0211.0/1564.html
www.cs.helsinki.fi/linux/linux-kernel/ 2002-47/0080.html

i'd welcome clues, and i'd be happy to run further tests if you tell me 
which :)

please cc: me on replies, i'm not subscribed, and the archives take ages 
to pick up new postings....

best,

jörn


-- 
If you're happy and you know it, bomb Iraq.

Jörn Nettingsmeier
Kurfürstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)




