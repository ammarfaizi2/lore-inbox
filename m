Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSACDfB>; Wed, 2 Jan 2002 22:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288169AbSACDev>; Wed, 2 Jan 2002 22:34:51 -0500
Received: from lsr-net2.nei.nih.gov ([128.231.132.10]:22947 "HELO
	lsr.nei.nih.gov") by vger.kernel.org with SMTP id <S288172AbSACDei>;
	Wed, 2 Jan 2002 22:34:38 -0500
Date: Wed, 2 Jan 2002 22:33:09 -0500 (EST)
From: Art Hays <art@lsr.nei.nih.gov>
X-X-Sender: <art@lsr-linux>
To: <linux-kernel@vger.kernel.org>
Subject: kswapd etc hogging machine
Message-ID: <Pine.LNX.4.33.0201022214230.8413-100000@lsr-linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would appreciate any expert insight into a problem that is causing me 
considerable grief.  Please cc to me directly.  Thank you very much.

Problem:  kswapd, kreclaimd, kupdated push load average high during simple
tar.  Response of system drops such that even keystroke echos are
noticeably delayed.

Specifics:

Machine- 4 processor 700Mhz Dell with 4G Ram and 6G swap space running
stock Redhat 7.2 distribution.  All disks are SCSI using ext2.

Command- from a remote machine this command is executed to the Linux 
machine "tar cBf - . | rsh linux "(tar xBpf -)".

Manifestion of problem- As this command continues on a freshly booted 
Linux machine the free memory reported by 'top' slowly goes to a low 
number.  When it bottoms out, the processes 'kswapd', 'kreclaimd', and 
'kupdated' begin to run pushing the load average above 4 at times.  
Responsiveness of machine drops dramatically with even keystroke echos 
delayed for seconds.

I apologize if this is well known.  If there is a simple solution I would 
appreciate even a terse pointer to it.  Thanks.

-- 
Art Hays					avhays@nih.gov or art@lsr.nei.nih.gov
Bldg 49 Rm 2A50					(301) 496-7143 (voice)
Nat. Institutes of Health			(301) 402-0511 (fax)
Bethesda, MD  20892

