Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTC0XUJ>; Thu, 27 Mar 2003 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTC0XUJ>; Thu, 27 Mar 2003 18:20:09 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:42472 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261495AbTC0XUI>; Thu, 27 Mar 2003 18:20:08 -0500
Date: Thu, 27 Mar 2003 23:30:50 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Christoph Hellwig <hch@infradead.org>,
       David Ford <david+cert@blue-labs.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.66 buglet
Message-ID: <20030327233050.GD16251@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	David Ford <david+cert@blue-labs.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <3E827CDA.8030904@blue-labs.org> <20030327145440.A900@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327145440.A900@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 02:54:40PM +0000, Christoph Hellwig wrote:
 > +	error = devfs_mk_symlink("cpu/microcode", "../misc/microcode");

Where did ../misc/microcode come from? That sounds horribly
generic compared to /dev/cpu/microcode

		Dave
