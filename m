Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbTAVKK6>; Wed, 22 Jan 2003 05:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTAVKK6>; Wed, 22 Jan 2003 05:10:58 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:14057 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S267412AbTAVKK6>;
	Wed, 22 Jan 2003 05:10:58 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15918.28753.632988.981832@harpo.it.uu.se>
Date: Wed, 22 Jan 2003 11:20:01 +0100
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess
In-Reply-To: <20030122105105.Z628@nightmaster.csn.tu-chemnitz.de>
References: <200301201341.OAA23795@harpo.it.uu.se>
	<20030122105105.Z628@nightmaster.csn.tu-chemnitz.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
 > On Mon, Jan 20, 2003 at 02:41:03PM +0100, Mikael Pettersson wrote:
 > > Booting kernel 2.5.59 with the "-s" kernel boot parameter
 > > doesn't get you into single-user mode like it should.
 > 
 > Try using "s" instead. This works since ever. I didn't even know,
 > that the other option exists, too.

That's a workaround for this particular case, but the name-munging
is still wrong and broken.

With "foo-bar=fie-fum" passed to the kernel, "foo_bar=fie-fum" is
what's put into init's environment. (I checked.)
