Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbUBZGMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 01:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbUBZGMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 01:12:13 -0500
Received: from [65.248.111.151] ([65.248.111.151]:63239 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S262699AbUBZGLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 01:11:53 -0500
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: linux-kernel@vger.kernel.org
Subject: Re: only ieee1394 from 2.4.20 works for me
Date: Thu, 26 Feb 2004 00:12:25 -0600
User-Agent: KMail/1.6.50
Cc: kai.engert@gmx.de
References: <4038BDC3.9030304@kuix.de> <Pine.LNX.4.58L.0402251153550.21511@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402251153550.21511@logos.cnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402260012.25098.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 February 2004 08:57, Marcelo Tosatti wrote:
> On Sun, 22 Feb 2004, Kai Engert wrote:
> > In the last year I have been playing with a variety of combinations of
> > ieee1394 controllers, machines, external mass storage devices and linux
> > kernel versions. So have some friends of mine.
> >
> > The only version that works for us is the ieee1394 code that was
> > included with kernel version 2.4.20.

Oddly enough I've been having trouble with ieee1394 too for quite some time (I 
was beginning to think my drive boxes were dead for some reason), and much to 
my pleasure your little trick works.

> >
> > (I removed drivers/ieee1394 completely, and replaced it with
> > drivers/ieee1394 from 2.4.20)
> >
> > Using that snapshot, we are able to transfer data to disks and video
> > from a camcorder just fine, in all combinations we have tested.
> >
> > Every other kernel version, both older or newer than 2.4.20, is broken.
> > We either see random errors, or writing data to disks stalls
> > immediately, or daisy chained devices don't work.

I however don't have the same problems you describe. Newer versions just 
simply fail to see anything attached to the ieee1394 bus. I'm using a via 
epia M10000. I saw a report similar to mine on the 1394 list, but it went 
unanswered.

> >
> > I'm currently using the official Fedora core 1 series kernels, patched
> > that way, and it works like a charm.
> >
> > Please consider to use the 2.4.20 ieee1394 snapshot in future 2.4.x
> > releases.

I'll be the first one to agree with ben that this is a bad idea.

>
> Hi Kai,
>
> As Ben already said, he needs a detailed report of your the problems.
>
> I'm sure he will work to fix them as soon as he has the reports.
>
> Get backtraces with Alt+SysRQ+T and Alt+SysRQ+P when the kernel hangs.

Unfortunately, I don't have any crashes, errors, or anything else helpful. 
I've tried different settings for debugging, none showed anything more 
revealing.

If there is anything that I can do (extra debugging patches, etc.) these boxes 
were bought for testing, and that's what they shall do.

--Brian Jackson

-- 
http://www.brianandsara.net
