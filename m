Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289082AbSAIXjP>; Wed, 9 Jan 2002 18:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289086AbSAIXjI>; Wed, 9 Jan 2002 18:39:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289082AbSAIXi5>; Wed, 9 Jan 2002 18:38:57 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: absolute path of a process
Date: 9 Jan 2002 15:38:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a1ik9l$hgf$1@cesium.transmeta.com>
In-Reply-To: <3C3C8188.E5F7677E@nbnet.nb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C3C8188.E5F7677E@nbnet.nb.ca>
By author:    Senhua Tao <stao@nbnet.nb.ca>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
>     I am new to linux kernel. I like to know is there any way to find
> the absolute path of a process.  I mean, how the kernel  knows which
> process is currently running? I tried to follow  the current  variable
> but got lost. Is the inode struct should I look at?
> 

Examine /proc/self/exe.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
