Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289016AbSBDPWs>; Mon, 4 Feb 2002 10:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSBDPWi>; Mon, 4 Feb 2002 10:22:38 -0500
Received: from 216-42-72-147.ppp.netsville.net ([216.42.72.147]:4017 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S289016AbSBDPWW>; Mon, 4 Feb 2002 10:22:22 -0500
Date: Mon, 04 Feb 2002 10:21:05 -0500
From: Chris Mason <mason@suse.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Chris Wedgwood <cw@f00f.org>
cc: Stephen Lord <lord@sgi.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <akpm@zip.com.au>, Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
Message-ID: <402060000.1012836065@tiny>
In-Reply-To: <3C5EA30D.8B51C639@mandrakesoft.com>
In-Reply-To: <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random> <242700000.1012680610@tiny> <3C5C4929.5080403@sgi.com> <20020202155028.B26147@havoc.gtf.org> <3C5D3DE9.4080503@sgi.com> <20020203140926.GA14532@tapu.f00f.org> <3C5D51A0.4050509@sgi.com> <20020203224406.GA17396@tapu.f00f.org> <3C5EA30D.8B51C639@mandrakesoft.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, February 04, 2002 10:04:45 AM -0500 Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> Chris Wedgwood wrote:
>> 
>> On Sun, Feb 03, 2002 at 09:05:04AM -0600, Stephen Lord wrote:
>> 
>>     I agree is is not a big issue in this case - my interpretation of
>>     tails was the end of any file could be packed, but if it is only
>>     small files.....
>> 
>> But you can't mmap (say) a 1k file right now...  so right now this
> 
> huh?  You can mmap a file of any size > 0.  Is this a reiserfs
> limitation or something?
> 

No, reiserfs can mmap files of size 1k.  Data past the end of file is
zerod on write.

-chris

