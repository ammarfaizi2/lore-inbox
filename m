Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262292AbTC1IOy>; Fri, 28 Mar 2003 03:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262428AbTC1IOy>; Fri, 28 Mar 2003 03:14:54 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:34321 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262292AbTC1IOy>; Fri, 28 Mar 2003 03:14:54 -0500
Date: Fri, 28 Mar 2003 08:26:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       David Ford <david+cert@blue-labs.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66 buglet
Message-ID: <20030328082607.A13326@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	David Ford <david+cert@blue-labs.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3E827CDA.8030904@blue-labs.org> <20030327145440.A900@infradead.org> <20030327233050.GD16251@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030327233050.GD16251@suse.de>; from davej@codemonkey.org.uk on Thu, Mar 27, 2003 at 11:30:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 11:30:50PM +0000, Dave Jones wrote:
> On Thu, Mar 27, 2003 at 02:54:40PM +0000, Christoph Hellwig wrote:
>  > +	error = devfs_mk_symlink("cpu/microcode", "../misc/microcode");
> 
> Where did ../misc/microcode come from? That sounds horribly
> generic compared to /dev/cpu/microcode

devfs automatically registers /dev/misc/<name> entries for any minor
registered by misc_register.

