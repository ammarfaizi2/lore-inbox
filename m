Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292211AbSBBDRi>; Fri, 1 Feb 2002 22:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292213AbSBBDR3>; Fri, 1 Feb 2002 22:17:29 -0500
Received: from mx2.fuse.net ([216.68.1.120]:37331 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S292211AbSBBDRO>;
	Fri, 1 Feb 2002 22:17:14 -0500
Message-ID: <3C5B5A2E.1050209@fuse.net>
Date: Fri, 01 Feb 2002 22:17:02 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Quick question about i8xx RNG.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the last handful of kernels (2.4.16, 2.4.17, a few 2.4 -pre's, 
2.5.2-dj5, -dj6, and 2.5.3-dj1), attempting to insert i810_rng gives "no 
such device."  I know this is a 81x chipset system (Sony VAIO R505JE) 
[lspci reports it as a "82815 815 Chipset Host Bridge and Memory 
Controller Hub" along with its other functions].

So the question is thus: is this correct?  Is there supposed to be a RNG 
with all 8xx chipsets [this is what I've heard.... if so, why does 
module init fail?] or is it an option and I just don't have it?

--Nathan


