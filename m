Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264994AbSJVUt6>; Tue, 22 Oct 2002 16:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264995AbSJVUt6>; Tue, 22 Oct 2002 16:49:58 -0400
Received: from trillium-hollow.org ([209.180.166.89]:40078 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S264994AbSJVUt5>; Tue, 22 Oct 2002 16:49:57 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I386 cli 
In-Reply-To: Your message of "Tue, 22 Oct 2002 22:46:44 +0200."
             <20021022224644.A25463@ucw.cz> 
Date: Tue, 22 Oct 2002 13:55:49 -0700
From: erich@uruk.org
Message-Id: <E184645-0002hK-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vojtech Pavlik <vojtech@suse.cz> wrote:

...
> > I'm sure there is no definition because "cli" is the native assembler
> > instruction on x86.
> 
> Wrong reason. Furthermore, cli(), meaning 'global interrupt disable,
> across all processors', is not doable with a single instruction anyway.
> It's not defined, because it should not be used - usually the usage of
> cli() means a bug.

Yeah, I noticed I made a thinko here by not looking at the file itself,
and assuming it was just a direct assembler hack...  essentially the
C-level variant of what is called in most OSes "splhi/spllo" rather
than "cli/sti", probably because that was how it was originally
used.

Good that it's finally getting purged.

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
