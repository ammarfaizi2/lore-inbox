Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWBJRDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWBJRDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWBJRDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:03:25 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:55719 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751302AbWBJRDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:03:24 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-ID: <17388.51036.848700.324427@gargle.gargle.HOWL>
Date: Fri, 10 Feb 2006 20:03:24 +0300
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Newsgroups: gmane.linux.kernel
In-Reply-To: <43ECA3FC.nailJGC110XNX@burner>
References: <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
	<43EB7BBA.nailIFG412CGY@burner>
	<mj+md-20060209.173519.1949.atrey@ucw.cz>
	<43EC71FB.nailISD31LRCB@burner>
	<20060210114721.GB20093@merlin.emma.line.org>
	<43EC887B.nailISDGC9CP5@burner>
	<mj+md-20060210.123726.23341.atrey@ucw.cz>
	<43EC8E18.nailISDJTQDBG@burner>
	<Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr>
	<43EC93A2.nailJEB1AMIE6@burner>
	<20060210141651.GB18707@thunk.org>
	<43ECA3FC.nailJGC110XNX@burner>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling writes:
 > "Theodore Ts'o" <tytso@mit.edu> wrote:
 > 
 > > On Fri, Feb 10, 2006 at 02:22:42PM +0100, Joerg Schilling wrote:
 > > > >
 > > > > The struct stat->st_rdev field need to be stable too to comply to POSIX?
 > > > 
 > > > Correct.
 > > > 
 > >
 > > Chapter and verse, please?  
 > >
 > > Can you please list the POSIX standard, section, and line number which
 > > states that a particular device must always have the same st_rdev
 > > across reboots, and hot plugs/unplugs?
 > 
 > A particular file on the system must not change st_dev while the system
 > is running.

Where is that from?

 > 
 > http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html

This text doesn't seem to support your claim.

 > 
 > Jörg

Nikita.
