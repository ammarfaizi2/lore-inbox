Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTLaNTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 08:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTLaNTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 08:19:06 -0500
Received: from intra.cyclades.com ([64.186.161.6]:4250 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264476AbTLaNTA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 08:19:00 -0500
Date: Wed, 31 Dec 2003 11:13:57 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.24-pre3
Message-ID: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here goes -pre3. It contains a PPC32/SPARC update, some i2c cleanups, LVM
update, network update, a new WAN driver, amongst others.

It should show up in ftp.kernel.org in a few minutes.

Happy new year!


Summary of changes from v2.4.24-pre2 to v2.4.24-pre3
============================================

<khali:linux-fr.org>:
  o i2c cleanup: Fix dependancies between the various SCx200 drivers
  o i2c cleanup: Remove old compatibility code
  o i2c cleanup: documentation

<marcelo:logos.cnet>:
  o Changed EXTRAVERSION to -pre3
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20031228201456|00847
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20031228200956|00864
  o Cset exclude: marcelo@logos.cnet|ChangeSet|20031231111415|59075

<mfedyk:matchmail.com>:
  o Use "%u" when printing extended /proc/partitions statistics
  o extended stats correction: Field rd_ios can be negative

<mgalgoci:redhat.com>:
  o Trivial SubmittingDrivers fix

<nuno:itsari.org>:
  o Ulrich Drepper: fix 'noexec' behaviour

<waltabbyh:comcast.net>:
  o Fix pdcraid geometry detection

<xose:wanadoo.es>:
  o LVM 1.0.8 update

Adrian Bunk:
  o dep_tristate wants 3 arguments (fwd)

Alan Cox:
  o 2.4 zr36120 missing dependancies

Bart De Schuymer:
  o [BRIDGE]: Fix loopback over bridge port

David S. Miller:
  o [SPARC64]: On Sabre, only access PCI controller config space specially
  o [SPARC64]: Update defconfig

Eyal Lebedinsky:
  o Fix cciss build problem

Hideaki Yoshifuji:
  o [NET]: Fix mis-spellings in net/core/neighbour.c

James McMechan:
  o Fix tmpfs dcache oops

Keith M. Wesolowski:
  o [SPARC32]: Add myself as maintainer

Krzysztof Halasa:
  o Goramo PCI200SYN sync card driver
  o Generic HDLC cleanup

Michael Hunold:
  o change two annoying messages from fb drivers (clgenfb and hgafb)

Patrick McHardy:
  o [PKT_SCHED]: Fix module refcount and mem leaks in classful qdiscs
  o [PKT_SCHED]: Remove backlog accounting from TBF, pass limit to default inner bfifo qdisc only

Ralf Bächle:
  o de4x5 EISA fix

Tom Rini:
  o PPC32: Two warning fixes, from Geert Uytterhoeven <geert@linux-m68k.org>
  o PPC32: Remove ASYNC_SKIP_TEST from all of our serial flags
  o PPC32: Add a watchdog driver for MPC8xx machines
  o PPC32: Add a CONFIG_OOM_KILLER entry
  o PPC32: Fix dependancies on the bootwrapper ld script
  o PPC32: Fix a warning on 'make zImage' for a number of platforms
  o PPC32: Add support for the Motorola Sandpoint X3 (all revs)
  o PPC32: Add support for the Motorola PRPMC750
  o PPC32: Fix the mkprep util to work correctly on Solaris 8
  o PPC32: Fix znetboot and znetboot.initrd Original patch from Eugene Surovegin <ebs@ebshome.net>, with a few more changes from myself.

