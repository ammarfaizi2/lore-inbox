Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273985AbRJDNVb>; Thu, 4 Oct 2001 09:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273994AbRJDNVV>; Thu, 4 Oct 2001 09:21:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24113 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273985AbRJDNVH>; Thu, 4 Oct 2001 09:21:07 -0400
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu>
	<m14rpg0w4a.fsf@frodo.biederman.org> <20011004182127.B512@zip.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Oct 2001 07:11:58 -0600
In-Reply-To: <20011004182127.B512@zip.com.au>
Message-ID: <m1zo77zh0h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT <cat@zip.com.au> writes:

> On Thu, Oct 04, 2001 at 12:15:01AM -0600, Eric W. Biederman wrote:
> > I have days when I'm frustrated by the size of both glibc and the
> > linux kernel.  stripped both the linux kernel and glibc are comparable
> > in size.  Though I think the 400KB of compressed glibc-2.1.2 is
> > actually smaller than the kernel for the most part.  I have to strip
> > off practically everthing to get a useable bzImage under 400KB.
> > 
> > So any good ideas on how to get the size of linux down?
> 
> Mind if I ask why you need a bzimage under 400kb? Just curious as I've
> never had the need. (And I can see needing it less then 1.4meg - are you
> trying to get a kernel AND a ramdisk on the one floppy?)

floppies have lots of room.

I'd like to get a kernel, ramdisk, and some hw initialization code all
on a 256KB ROM.  I have my ramdisk down to about 14KB compressed.  I
have my hw initialization code down to 32KB uncompressed (and I might
be able to reduce that further). So I want something like a 192KB
(compressed) linux kernel.   

If I had that some of the hard problems of with linuxBIOS would just
drop away.

Eric
