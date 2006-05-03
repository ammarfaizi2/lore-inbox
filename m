Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965232AbWECPrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWECPrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbWECPrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:47:03 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:61085 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965232AbWECPrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:47:01 -0400
Date: Wed, 3 May 2006 17:47:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jared Hulbert <jaredeh@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Advanced XIP File System
Message-ID: <20060503154700.GD5250@wohnheim.fh-wedel.de>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com> <20060503130502.GD19537@wohnheim.fh-wedel.de> <6934efce0605030831h30d7e4e3hb057fd1b3f7791d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6934efce0605030831h30d7e4e3hb057fd1b3f7791d3@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 08:31:50 -0700, Jared Hulbert wrote:
> 
> >o Consider saving a zlib workspace by moving it out of your code and
> >  sharing the infrastructure with cramfs and jffs2
> 
> Hmmm.  Can you explain what you mean by this.  That would require
> modifying each of the 3 filesystems.

Correct.  It is not a must-fix, but having seperate workspaces for all
the filesystems seems wasteful.

Jörn

-- 
Unless something dramatically changes, by 2015 we'll be largely
wondering what all the fuss surrounding Linux was really about.
-- Rob Enderle
