Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbSKSOlh>; Tue, 19 Nov 2002 09:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSKSOlh>; Tue, 19 Nov 2002 09:41:37 -0500
Received: from [195.223.140.107] ([195.223.140.107]:39826 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265373AbSKSOlg>;
	Tue, 19 Nov 2002 09:41:36 -0500
Date: Tue, 19 Nov 2002 15:48:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, margit@margit.com
Subject: Re: Linux 2.4.19 patch for Suse compatibility
Message-ID: <20021119144801.GN29722@dualathlon.random>
References: <p73d6p1vi7c.fsf@oldwotan.suse.de> <Pine.LNX.4.44L.0211191132280.1571-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211191132280.1571-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 11:32:45AM -0200, Rik van Riel wrote:
> On 19 Nov 2002, Andi Kleen wrote:
> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > > This was discussed on the kernel list about four to six weeks ago and
> > > rejected then as well. See the previous discussion
> >
> > Actually I don't remember it being rejected, just the discussion dropped
> > off and there was no suggestion on how to solve the problem this ioctl
> > solves in a better way.
> 
> So, what problem does it try to solve ?

how can you find the real device behind /dev/console without such ioctl?
An userspace hack watching /proc/cmdline wouldn't be reliable.

Andrea
