Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbTAXGJi>; Fri, 24 Jan 2003 01:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTAXGJi>; Fri, 24 Jan 2003 01:09:38 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:5001 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S267558AbTAXGJh>; Fri, 24 Jan 2003 01:09:37 -0500
Date: Fri, 24 Jan 2003 06:19:51 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein31.homenet>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Arjan van de Ven <arjanv@redhat.com>, Christoph Hellwig <hch@lst.de>,
       Hugh Dickins <hugh@veritas.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
In-Reply-To: <20030114174003.GB9469@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.33.0301240618130.1111-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Dave Jones wrote:

> On Tue, Jan 14, 2003 at 05:29:58PM +0000, Tigran Aivazian wrote:
>
>  > No, because cat is using 4K chunks and the data has to be written in one
>  > large chunk, like this:
>  >
>  > # dd if=microcode of=/dev/cpu/microcode bs=141312 count=1
>  >
>  > This actually works fine but you need to convert microcode data from human
>  > readable (what Intel distribute) to binary format first. Easily done with
>  > microcode_ctl utility.
>
> What about the dumps Christian Ludhoff put at ftp.sandpile.org/mcupdate ?
> These are binary data, but are they in the right format to be used ?
> I'm curious if these are newer than the ones described in microcode.dat,
> but haven't had time to dig through the dates on them.
>

Most likely they are NOT newer than the ones I receive from Intel (because
I assume Intel distribute their updates more or less simultaneously to all
OS/BIOS vendors). As soon as I get updates from Intel they will be
uploaded for general consumption, of course.

Regards
Tigran

