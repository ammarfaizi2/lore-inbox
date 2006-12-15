Return-Path: <linux-kernel-owner+w=401wt.eu-S1753385AbWLOULx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbWLOULx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbWLOULx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:11:53 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:63487 "EHLO
	sbcs.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbWLOULw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:11:52 -0500
Date: Fri, 15 Dec 2006 15:11:49 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Ed Tomlinson <edt@aei.ca>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <200612150747.02708.edt@aei.ca>
Message-ID: <Pine.GSO.4.53.0612151504360.3466@compserv1>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1> <200612150747.02708.edt@aei.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wednesday 13 December 2006 12:47, Nikolai Joukov wrote:
> > We have designed a new stackable file system that we called RAIF:
> > Redundant Array of Independent Filesystems
>
> Do you have a function similar to an an EMC cloneset?   Basicily a cloneset
> tracks what has changed in both the source and target luns (drives).  When one
> updates the cloneset the target is made identical to the source.  Its a great
> way to do backups.  Its an important feature to be able to write to the target drives.
> I would love to see this working at a filesystem level.

Well, if you mount RAIF over your file system and a for-backups file
system, RAIF can replicate the files on both of them automatically.  I
guess that's what you need.

Nikolai.
---------------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
