Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267332AbTAGHtq>; Tue, 7 Jan 2003 02:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267333AbTAGHtq>; Tue, 7 Jan 2003 02:49:46 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:54799 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S267332AbTAGHtp>;
	Tue, 7 Jan 2003 02:49:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Derek Fountain <derekfountain@lycos.co.uk>
To: Oleg Drokin <green@namesys.com>
Subject: Re: LVM, NFS, Reiser and ext3
Date: Tue, 7 Jan 2003 08:59:19 +0000
User-Agent: KMail/1.4.3
References: <200301060947.53043.derekfountain@lycos.co.uk> <20030106132129.A2254@namesys.com>
In-Reply-To: <20030106132129.A2254@namesys.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301070859.19367.derekfountain@lycos.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 January 2003 10:21, you wrote:
> Hello!
>
> On Mon, Jan 06, 2003 at 09:47:53AM +0000, Derek Fountain wrote:
> > correctly written NFS transfers later, I'm seeing errors on read like:
> > Jan  6 16:26:47 beetle kernel: EXT3-fs error (device lvm(58,0)):
> > ext3_readdir: bad entry in directory #229383: rec_len is too small for
> > name_len - offset=504, inode=229395, rec_len=36, name_len=36
> > and lots and lots of:
> > Jan  6 16:29:34 beetle kernel: attempt to access beyond end of device
> > Jan  6 16:29:34 beetle kernel: 3a:00: rw=0, want=629932036, limit=5242880
> > Is there reason to believe that LVM, NFS and jouralling file systems
> > don't get along?
>
> No
> Looks like there is something with your hardware
> Does corruption go away if you use physical volumes without LVM (try each
> volume of three)?

Yes. It's been running like that for 3 years 24x7 on a 2.2 kernel. Not a 
hiccup. I've made the three PVs back into normal reiserfs disks and they're 
now running happily again.

-- 
Australian Linux Technical Conference 2003: http://www.linux.conf.au/

Explain to your boss the benefits of you going...
