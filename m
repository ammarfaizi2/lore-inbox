Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTDXOcb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTDXOcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:32:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57862 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263762AbTDXOca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:32:30 -0400
Date: Thu, 24 Apr 2003 07:45:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Bradford <john@grabjohn.com>
cc: Jamie Lokier <jamie@shareable.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
In-Reply-To: <200304240816.h3O8GGrH000399@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.44.0304240741530.20549-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 24 Apr 2003, John Bradford wrote:
> 
> Incidently, using the Transmeta CPUs, is it not possible for the user
> to replace the controlling software with their own code?  I.E. not
> bother with X86 compatibility at all, but effectively design your own
> CPU?  Couldn't we make the first Lin-PU this way?

Well, I have to say that Transmeta CPU's aren't exactly known for their 
openness ;)

Also, the native mode is not very pleasant at all, and it really is 
designed for translation (and with a x86 flavour, too). You might as well 
think of it as a microcode on steroids.

If open hardware is what you want, FPGA's are actually getting to the
point where you can do real CPU's with them. They won't be gigahertz, and
they won't have big nice caches (but hey, you might make something that
clocks fairly close to memory speeds, so you might not care about the
latter once you have the former).

They're even getting reasonably cheap.

		Linus

