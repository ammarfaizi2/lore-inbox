Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284133AbRLWUBZ>; Sun, 23 Dec 2001 15:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284140AbRLWUBO>; Sun, 23 Dec 2001 15:01:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284133AbRLWUBG>; Sun, 23 Dec 2001 15:01:06 -0500
Message-ID: <3C2637EF.4050007@zytor.com>
Date: Sun, 23 Dec 2001 12:00:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
In-Reply-To: <Pine.GSO.4.21.0112230849550.23300-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> 
>>b) No obvious ways to handle hard links, that doesn't require you 
>>keeping a table of the inode numbers already seen (at least for which 
>>c_nlink > 1) and hard link to them on the decompression side.  Since we 
>>have an assymetric setup, it seems like its done at the wrong end.
>>
> 
> See below.
> 


What I perhaps am calling for more than anything else is very precisely 
defined semantics of when hard links are generated, and how to control 
that.  Anyway, I'm about to leave for the holidays, and won't have 
email, but I'll think a bit more about this over that time.

	-hpa


