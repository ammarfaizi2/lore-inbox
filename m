Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264074AbTHWNiV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTHWNiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:38:21 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:5791
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264074AbTHWNiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:38:18 -0400
Date: Sat, 23 Aug 2003 09:47:37 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: evms or lvm?
Message-ID: <20030823094737.C995@animx.eu.org>
References: <3F47347F.7070103@mscc.huji.ac.il> <20030823101831.GA2857@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030823101831.GA2857@localhost>; from Jose Luis Domingo Lopez on Sat, Aug 23, 2003 at 12:18:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.6.0 will have many changes with respect to LVM and EVMS. LVM is
> updated to newer version 2 (LVM2), based on DM (Device Mapper), sort of
> a simplified in-kernel LVM that just handles discovering the drives.
> Updated userspace utilities (LVM2) are already available to drive this.
> 
> On the other part, EVMS was completely redesigned. Former EVMS
> implementation was duplicating too much code, and in general it was
> regarded as a bad implementation on a very good idea, so the people at
> IBM in charge on EVMS development took what it look to everyone as a
> very clever move, and for 2.6.x they implemented EVMS on top of DM. User
> space utilities for EVMS are (from the user's point of view) the same as
> before, but now the inner details are different: no reimplementation of
> software RAID, no reimplementation of LVM, etc.

I noticed the kernel doesn't have LVM as an option now.  Does both projects
just use the DM from userspace?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
