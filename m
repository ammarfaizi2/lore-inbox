Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSEYC2I>; Fri, 24 May 2002 22:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313242AbSEYC2H>; Fri, 24 May 2002 22:28:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1805 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313238AbSEYC2G>; Fri, 24 May 2002 22:28:06 -0400
Message-ID: <3CEEF69D.8040908@zytor.com>
Date: Fri, 24 May 2002 19:27:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>, ftpadmin@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.18
In-Reply-To: <Pine.LNX.4.44.0205241920230.3909-100000@home.transmeta.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 24 May 2002, Alexander Viro wrote:
> 
>>Erm.  Looks like ftp.kernel.org is neither here nor there.  Or, at least,
>>doesn't accept connections to ports 21 and 80...
> 
> Hmm.. Right you are. I always push my kernels to "master.kernel.org", and
> they get mirrored from there automatically, but yes, something appears
> broken with the rest of kernel.org..
> 

kernel.org had a multiple-disk failure and lost its archive RAID.  From 
the looks of it, several disks started developing "threshhold" failures 
at least two weeks ago, possibly in conjunction with the system being 
moved to a new rack.  Unfortunately the RAID controller didn't down the 
disks as they started having problems, and the system was allowed to 
keep running until it finally crashed due to data corruption.

Compaq is investigating the failure, and will probably give us the 
hardware for the #2 server that we asked for a few months ago (they've 
been occupied with some kind of merger...)

	-hpa


