Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265745AbUFXVtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUFXVtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbUFXVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:48:04 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:28327 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S265745AbUFXVo3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:44:29 -0400
Date: Thu, 24 Jun 2004 13:51:36 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@www.fnordora.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       <linux-kernel@vger.kernel.org>, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
In-Reply-To: <20040624213041.GA20649@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0406241347560.18047-100000@www.fnordora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004, Pavel Machek wrote:

> Okay, lets make it explicit.
> 
> On one school server, theres 10MB quota. (Okay, its admins are
> BOFHs^H^H^H^H^HSISAL). Everyone tries to run mozilla there (because
> its installed as default!), and immediately fills his/her quota with
> cache files, leading to failed login next time (gnome just will not
> start if it can't write to ~).
> 
> Imagine mozilla automatically marking cache files "elastic".
> 
> That would solve the problem -- mozilla caches would go away when disk
> space was demanded, still mozilla's on-disk caching would be effective
> when there is enough disk space.

How does Mozilla (or any process) react when its files are deleted from 
under it?  Would the file remain until all the open processes close the 
file or would it just "disappear"?  Would it delete entire directories or 
just some of the files?  How does it choose?  (First up against the delete 
when the drive space fills...)


