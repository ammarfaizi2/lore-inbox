Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280845AbRKBVUc>; Fri, 2 Nov 2001 16:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280844AbRKBVUW>; Fri, 2 Nov 2001 16:20:22 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22510
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280840AbRKBVUN>; Fri, 2 Nov 2001 16:20:13 -0500
Date: Fri, 2 Nov 2001 13:20:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Weird /proc/meminfo output on 2.4.13-ac5
Message-ID: <20011102132006.A5955@mikef-linux.matchmail.com>
Mail-Followup-To: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Andreas Franck <Andreas.Franck@akustik.rwth-aachen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <80D19CC2E32@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80D19CC2E32@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 07:34:49PM +0000, Petr Vandrovec wrote:
> On  2 Nov 01 at 14:10, Andreas Franck wrote:
> > $ cat /proc/meminfo
> >         total:    used:    free:  shared: buffers:  cached:
> > Mem:  789250048 781295616  7954432   659456 402890752
> > 18446744073478758400
> > Swap: 6744576000   282624 6744293376
> > MemTotal:       770752 kB
> > MemFree:          7768 kB
> > MemShared:         644 kB
> > Buffers:        393448 kB
> > Cached:       4294741680 kB     <------ This is impossible, i think? :-)
> 
> Problem appeared in my 2.4.13-ac4 yesterday at home too. It happened to 
> me when I was checking health of my HDD - either during 'dd if=/dev/hde1 
> of=/dev/null bs=8M', or during copying all files from VFAT (/dev/hde1) 
> partition to /dev/null on filesystem level file by file. 
> 
> And if we are talking about it, 2.4.13-ac4 here at work reports that
> too. But strange thing is that this machine has just 200MB VFAT partition
> of no use, and I do not remember that I ever did read from /dev/hd* since
> last reboot. Shift-scrolllock does not report any unusual values. 
> 
> I'll upgrade to -ac6 and I'll see.

It won't help.  You'll need a patch that rik has posted a few days ago.

This problem is for 2.4.13, 2.4.13-acX, and 2.4.14pre*.

Latest pre or ac patches don't fix it.

Latest:
pre6
-ac6

Mike
