Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262956AbTC1LAd>; Fri, 28 Mar 2003 06:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262958AbTC1LAd>; Fri, 28 Mar 2003 06:00:33 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:34200 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S262956AbTC1LAc>; Fri, 28 Mar 2003 06:00:32 -0500
Date: Fri, 28 Mar 2003 11:11:17 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       David Ford <david+cert@blue-labs.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66 buglet
Message-ID: <20030328111117.GB32101@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	David Ford <david+cert@blue-labs.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3E827CDA.8030904@blue-labs.org> <20030327145440.A900@infradead.org> <20030327233050.GD16251@suse.de> <20030328082607.A13326@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328082607.A13326@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 08:26:07AM +0000, Christoph Hellwig wrote:
 > >  > +	error = devfs_mk_symlink("cpu/microcode", "../misc/microcode");
 > > Where did ../misc/microcode come from? That sounds horribly
 > > generic compared to /dev/cpu/microcode
 > 
 > devfs automatically registers /dev/misc/<name> entries for any minor
 > registered by misc_register.

That's pretty fucked up IMO. Is it feasable that we could one day
have /dev/$otherhardware/microcode, and that would completely
screw up this devfs 'feature' ?

		Dave

