Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283045AbRLWAqj>; Sat, 22 Dec 2001 19:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283003AbRLWAqT>; Sat, 22 Dec 2001 19:46:19 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:49924 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S283002AbRLWAqO>; Sat, 22 Dec 2001 19:46:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Alexander Viro <viro@math.psu.edu>,
        "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 19:44:49 -0500
X-Mailer: KMail [version 1.3.2]
Cc: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Hwks-0001wV-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 December 2001 15:26, Alexander Viro wrote:
> On Tue, 18 Dec 2001, Grover, Andrew wrote:
> > I'm not arguing that the new initrd won't be better than the old initrd
> > (because obviously you are right) I'm arguing that no matter how whizzy
> > initrd is, it's still an unnecessary step, and it's one that other OSs
> > (e.g. FreeBSD) omit in favor of the approach I'm advocating.
>
> Learn to read.  You don't _have_ to have initrd.  At all.  There's nothing
> to stop your loader from putting whatever cpio archive it likes - it
> doesn't involve anything other than slapping files you want together
> putting their owner/group/size/timestamps/mode/name before each of them.
> Anything that puts a bunch of modules in core will have to do equivalent
> job.

Deja Vu: *shrug*  Your "all they have to do" is quite heavy.
(boot loader must implement full cpio/tar[/gzip}

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
