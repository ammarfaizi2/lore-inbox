Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283688AbRLECAM>; Tue, 4 Dec 2001 21:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283691AbRLECAD>; Tue, 4 Dec 2001 21:00:03 -0500
Received: from bergeron.research.canon.com.au ([203.12.172.124]:52153 "HELO
	a.mx.canon.com.au") by vger.kernel.org with SMTP id <S283688AbRLEB7u>;
	Tue, 4 Dec 2001 20:59:50 -0500
Date: Wed, 5 Dec 2001 12:59:38 +1100
From: Cameron Simpson <cs@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011205125938.A21170@zapff.research.canon.com.au>
Reply-To: cs@zip.com.au
In-Reply-To: <20011204120305.A16578@thyrsus.com> <E16BJcB-0002o7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BJcB-0002o7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Dec 04, 2001 at 05:44:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 05:44:19PM +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
| > After CML2 has proven itself in 2.5, I do plan to go back to Marcelo
| > and lobby for him accepting it into 2.4, on the grounds that doing so
| > will simplify his maintainance task no end.  That's why I'm tracking
| > both sides of the fork in the rulebase, so it will be an easy drop-in
| > replacement for Marcelo as well as Linus.
| 
| Thats somewhat impractical. You will break all the existing additional
| configuration tools for the 2.4 stable tree that people expect to continue
| to work
| 
| Breaking them in 2.5 isnt a big issue, but breaking stable kernel trees
| is a complete nono

Folks, have you forgotten that you're programmers?

ESR, is it practical to have CML2 transcribe a CML1 config file?
Then as part of the build-the-kernel-src-tarball, Marcelo or whoever's
make target runs the transcriber.

This would let people fetch a kernel and build with the old tools
for personal hacking purposes which keeping the source config in CML2
which is cleans and more powerful. Kernel code _authors_ would need to
write in CML2, but not kernel end users.
-- 
Cameron Simpson, DoD#743        cs@zip.com.au    http://www.zip.com.au/~cs/

A motorcycle is like a toothbrush.  Everyone should have their own.
	- roserunr@noller.com
