Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286339AbSBSS1l>; Tue, 19 Feb 2002 13:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbSBSS1Y>; Tue, 19 Feb 2002 13:27:24 -0500
Received: from mx0.gmx.de ([213.165.64.100]:47129 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S286322AbSBSS1G>;
	Tue, 19 Feb 2002 13:27:06 -0500
Date: Tue, 19 Feb 2002 19:27:00 +0100 (MET)
From: cschumpf@gmx.net
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Patch or module?
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014208664@gmx.net
X-Authenticated-IP: [195.20.224.6]
Message-ID: <19933.1014143220@www57.gmx.net>
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

