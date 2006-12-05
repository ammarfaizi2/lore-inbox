Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968392AbWLEQEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968392AbWLEQEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968393AbWLEQEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:04:38 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:65401 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968392AbWLEQEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:04:37 -0500
Date: Tue, 5 Dec 2006 17:04:28 +0100
From: David Weinehall <tao@acc.umu.se>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mass-storage problems with Archos AV500
Message-ID: <20061205160428.GG14886@vasa.acc.umu.se>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20061129214736.GU14886@vasa.acc.umu.se> <20061201063225.64122205.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201063225.64122205.zaitcev@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 06:32:25AM -0800, Pete Zaitcev wrote:
> On Wed, 29 Nov 2006 22:47:36 +0100, David Weinehall <tao@acc.umu.se> wrote:
> 
> > I've got an Archos AV500 here (running the very latest firmware), pretty
> > much acting as a doorstop, since I cannot get it to be recognized
> > properly by Linux.
> >[...]
> > [  118.144000] SCSI device sdb: 58074975 512-byte hdwr sectors (29734
> > MB)
> > [  118.144000] sdb: Write Protect is off
> > [  118.144000] sdb: Mode Sense: 33 00 00 00
> > [  118.144000] sdb: assuming drive cache: write through
> > [  118.144000]  sdb: unknown partition table
> > [  118.452000] sd 4:0:0:0: Attached scsi removable disk sdb
> 
> It seems to be working just fine. What does parted say about it?

In the end it turned out not even Windows recognized the filesystem.
Reformatting solved the issue.  Sorry for the false alarm.


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
