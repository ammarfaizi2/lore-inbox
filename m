Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318134AbSHDJW3>; Sun, 4 Aug 2002 05:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318136AbSHDJW3>; Sun, 4 Aug 2002 05:22:29 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:53090 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S318134AbSHDJW3>; Sun, 4 Aug 2002 05:22:29 -0400
Date: Sun, 4 Aug 2002 12:25:43 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30: buffer layer error at page-writeback.c:417
Message-ID: <20020804092543.GD1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
References: <200208020726.51659.tomlins@cam.org> <20020803190734.GB1548@niksula.cs.hut.fi> <20020804081452.GC1548@niksula.cs.hut.fi> <3D4CE7C2.A2393F19@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4CE7C2.A2393F19@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2002 at 01:37:22AM -0700, you [Andrew Morton] wrote:
> Ville Herva wrote:
> > 
> > buffer layer error at page-writeback.c:417
> > Pass this trace through ksymoops for reporting
> 
> Is that on the ramdisk driver?

(I should warn that this is on vmware - I don't dare to boot 2.5 on bare
metal yet).

I do have ramdisk mounted:

/dev/ram0 /mounts ext2 rw 0 0

but I haven't used it much at all. I'm not sure howto tell if ramdisk
triggered the problem. I will boot without it and see if it happens again,
but that won't tell for sure if it was ramdisk or not.

Root fs is ext2 on /dev/sda1.


-- v --

v@iki.fi
