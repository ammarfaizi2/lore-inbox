Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130460AbQLOS1s>; Fri, 15 Dec 2000 13:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130464AbQLOS1i>; Fri, 15 Dec 2000 13:27:38 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:21477 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130460AbQLOS1U>; Fri, 15 Dec 2000 13:27:20 -0500
Date: Fri, 15 Dec 2000 19:56:11 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: ferret@phonewave.net
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
Message-ID: <20001215195611.L829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <FBF96516CD5@vcnet.vc.cvut.cz> <Pine.LNX.3.96.1001215093002.16439B-100000@tarot.mentasm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.96.1001215093002.16439B-100000@tarot.mentasm.org>; from ferret@phonewave.net on Fri, Dec 15, 2000 at 09:31:57AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 09:31:57AM -0800, ferret@phonewave.net wrote:
> > Maybe you did not notice, but for months we have
> > /lib/modules/`uname -r`/build/include, which points to kernel headers,
> > and which should be used for compiling out-of-tree kernel modules
> > (i.e. latest vmware uses this).
> 
> This symlink really should be a copy instead, because the finished kernel
> may be installed on a machine that does not have kernel source installed
> on it. Dangling symlinks are BAD.

But if you compile for another machine, this copy is bad. It also
takes to much time and space to create this copy.

I really disagree here.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
