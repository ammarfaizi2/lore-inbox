Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289571AbSBKODp>; Mon, 11 Feb 2002 09:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289566AbSBKODg>; Mon, 11 Feb 2002 09:03:36 -0500
Received: from dialin-145-254-129-003.arcor-ip.net ([145.254.129.3]:40458 "EHLO
	dale.home") by vger.kernel.org with ESMTP id <S289551AbSBKOD3>;
	Mon, 11 Feb 2002 09:03:29 -0500
Date: Mon, 11 Feb 2002 15:03:08 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020211150308.A14023@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020211085140.B27189@namesys.com> <Pine.LNX.4.44.0202111247270.21009-100000@Expansa.sns.it> <20020211131713.A8614@steel> <20020211160948.B7863@namesys.com> <20020211141422.A16832@steel> <20020211162743.A1282@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211162743.A1282@namesys.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 04:27:43PM +0300, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Feb 11, 2002 at 02:14:22PM +0100, Alex Riesen wrote:
> 
> > > .history may be corrupted if your partition was not unmounted properly
> > > before reboot.
> > but in that strange way? the sizes of the files are kept, just the content,
> > as were it's an empty page. Sadly that i haven't kept any of the files (unless
> > some i haven't found yet) to check it is page-aligned.
> This is nothing strange.
> You open file for writing, write some stuff, metadata gets journaled,
> but file content is not. Then you reboot, metadata is ok,
> but file content is lost.
> (and at least bash totally rewrites its .history file)

yes, that clear alot.
I cannot remember any problems while rebooting, but i'm not sure.

-alex

