Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289790AbSBOVkv>; Fri, 15 Feb 2002 16:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292161AbSBOVkm>; Fri, 15 Feb 2002 16:40:42 -0500
Received: from mx2.fuse.net ([216.68.1.120]:54515 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S289790AbSBOVk2>;
	Fri, 15 Feb 2002 16:40:28 -0500
Message-ID: <3C6D803C.5030006@fuse.net>
Date: Fri, 15 Feb 2002 16:40:12 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020203
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: ALSA fails to build sequencers?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been an issue for a long while in the alsa-driver CVS tree and 
now is an issue in 2.5.4-dj2: the only snd-seq-* module to be built is 
snd-seq-oss.o, the rest of them are not built at all.  Under the ALSA 
CVS tree I could build them manually, correctly - they were just skipped 
over in "make all."  I suspect this is  a trivial Makefile issue, but I 
have not found it in what time I have spent on it.


--Nathan


