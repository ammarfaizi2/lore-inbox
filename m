Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289886AbSA2VBq>; Tue, 29 Jan 2002 16:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289887AbSA2VBh>; Tue, 29 Jan 2002 16:01:37 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:36307 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S289886AbSA2VB3>;
	Tue, 29 Jan 2002 16:01:29 -0500
Date: Tue, 29 Jan 2002 16:01:29 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Vladimir Trebicky <trebi@post.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Memory Hole on 2.4
In-Reply-To: <003701c1a8f4$002f9710$1b00a8c0@guru>
Message-ID: <Pine.LNX.4.30.0201291558220.10200-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Vladimir Trebicky wrote:

> I want to upgrade from 2.2.16 to 2.4. I have Compaq Prosignia 300 with a
> memory hole, which cannot be turned off. There was no problem with that on
> 2.2.16, I just put "mem=64M" to kernel as a boot option. It does not appear
> to be functional on 2.4, I only finds 15MB. I use the same LILO v.21, rh6.2.

Well this is unrelated to your problem, but as a side-note: if you are
planning on using 2.4 going forward, you may need to upgrade some of your
OS-related tools like modutils, binutils, e2fsprogs, et al.  Look in
Documentation/Changes.

Again, this has nothing to do with your current memory hole issues, but it
is something to consider if you solve your memory hole issues.

I seem to remember being able to map out ranges of memory either as
parameters to the kernel.. or by editing a source file--so that if you
know the linear address of the memory range you want to omit, you can do
so.  Actually I think to do this you may need to modify one of the kernel
source files.  If you are willing to do this write me back and I will try
hard and remember which file you have to modify...

-Calin

