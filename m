Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTAFKMy>; Mon, 6 Jan 2003 05:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266438AbTAFKMy>; Mon, 6 Jan 2003 05:12:54 -0500
Received: from angband.namesys.com ([212.16.7.85]:22664 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266435AbTAFKMx>; Mon, 6 Jan 2003 05:12:53 -0500
Date: Mon, 6 Jan 2003 13:21:29 +0300
From: Oleg Drokin <green@namesys.com>
To: Derek Fountain <derekfountain@lycos.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LVM, NFS, Reiser and ext3
Message-ID: <20030106132129.A2254@namesys.com>
References: <200301060947.53043.derekfountain@lycos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200301060947.53043.derekfountain@lycos.co.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jan 06, 2003 at 09:47:53AM +0000, Derek Fountain wrote:

> correctly written NFS transfers later, I'm seeing errors on read like:
> Jan  6 16:26:47 beetle kernel: EXT3-fs error (device lvm(58,0)): ext3_readdir: 
> bad entry in directory #229383: rec_len is too small for name_len - 
> offset=504, inode=229395, rec_len=36, name_len=36
> and lots and lots of:
> Jan  6 16:29:34 beetle kernel: attempt to access beyond end of device
> Jan  6 16:29:34 beetle kernel: 3a:00: rw=0, want=629932036, limit=5242880
> Is there reason to believe that LVM, NFS and jouralling file systems don't get 
> along?

No.
Looks like there is something with your hardware.
Does corruption go away if you use physical volumes without LVM (try each volume
of three)?

Bye,
    Oleg
