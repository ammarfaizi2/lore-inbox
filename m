Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbSBSSYb>; Tue, 19 Feb 2002 13:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSBSSYW>; Tue, 19 Feb 2002 13:24:22 -0500
Received: from mx0.gmx.net ([213.165.64.100]:19940 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S285720AbSBSSYH>;
	Tue, 19 Feb 2002 13:24:07 -0500
Date: Tue, 19 Feb 2002 19:23:59 +0100 (MET)
From: cschumpf@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Patch or module?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014208664@gmx.net
X-Authenticated-IP: [195.20.224.6]
Message-ID: <18920.1014143039@www57.gmx.net>
X-Mailer: WWW-Mail 1.5 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If thats not the right group to discuss that, please let me know.

I would like to write an IO-Bandwidth-Limiter on per Process and per
User-Basis for a few disk drives. I can either patch the kernel functions read/write
and enhance the task- and user-structure and globally check if the correct
devices are adressed or I can write my own module, twist pointers from the
filesystems on the drives and store the information about users and tasks there.

I like the second approach way better, but its maybe slower. I have to do an
extra search in my structures for user and task ids, which is maybe more
expensive than an 'if' in the read/write-funktion.

Any guidelines? Any recommendations?

Thanks


-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net

