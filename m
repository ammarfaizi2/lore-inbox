Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267714AbTBRIa5>; Tue, 18 Feb 2003 03:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267715AbTBRIa4>; Tue, 18 Feb 2003 03:30:56 -0500
Received: from mail.hometree.net ([212.34.181.120]:27581 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S267714AbTBRIa4>; Tue, 18 Feb 2003 03:30:56 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: ext3 clings to you like flypaper
Date: Tue, 18 Feb 2003 08:40:56 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <b2srio$v2k$1@tangens.hometree.net>
References: <78320000.1045465489@[10.10.2.4]> <1045482621.29000.40.camel@passion.cambridge.redhat.com> <2460000.1045500532@[10.10.2.4]>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1045557656 31828 212.34.181.4 (18 Feb 2003 08:40:56 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 18 Feb 2003 08:40:56 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

>And in answer to some other questions:

>This machine can't boot off CD, so rescue disks are not an option.
>It's remote anyway, and I shouldn't have to screw around with it to do this.
>I'm not using initrd

>The point remains, if I say I want ext2, I should get ext2, not whatever 
>some random developer decides he thinks I should have. Worst of all,
>the system then lies to you and says it's mounted ext2 when it's not.

Don't compile any FS into the kernel. Load ext2 from an initrd. root
fs mounts as ext2 and you're happy.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire
