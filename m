Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUFYTly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUFYTly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUFYTlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:41:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:11743 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263775AbUFYTlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:41:52 -0400
Date: Fri, 25 Jun 2004 21:34:36 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Josh Boyer <jdub@us.ibm.com>
Cc: Pavel Machek <pavel@suse.cz>, alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040625193436.GC8656@wohnheim.fh-wedel.de>
References: <20040624220318.GE20649@elf.ucw.cz> <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org> <20040625001545.GI20649@elf.ucw.cz> <1088165267.8241.7.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1088165267.8241.7.camel@weaponx.rchland.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 June 2004 07:07:48 -0500, Josh Boyer wrote:
> 
> Couldn't most of this be done in userspace with xattrs and a "elastic
> quota" daemon?  Mark such files as elastic with an xattr, and when space
> is needed for user N, the daemon comes along and deletes the marked
> files.  You could even make the deamon semi-smart and take things such
> as filesize, least recently used files, etc into account.
> 
> Or maybe I am missing something...

"when space is needed" is hard to detect for the daemon.

Jörn

-- 
To my face you have the audacity to advise me to become a thief - the worst
kind of thief that is conceivable, a thief of spiritual things, a thief of
ideas! It is insufferable, intolerable!
-- M. Binet in Scarabouche
