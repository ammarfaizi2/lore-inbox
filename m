Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbULRRuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbULRRuD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 12:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbULRRuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 12:50:02 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:37795 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261207AbULRRt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 12:49:58 -0500
Date: Sat, 18 Dec 2004 18:49:53 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041218174953.GA4147@wohnheim.fh-wedel.de>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com> <20041216113357.4c2714bb@lembas.zaitcev.lan> <20041216194224.GA6640@kroah.com> <20041217190856.GA29131@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041217190856.GA29131@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 December 2004 20:08:56 +0100, Pavel Machek wrote:
> > 
> > So, /debug sounds good to me.  Any objections?
> 
> Yes... /debug is something users may actually use already... Like
> having scratch filesystem mount on /debug.

Wouldn't it be possible to parse /proc/mounts and determine the
correct mount point that way?

DEBUGFS = grep debugfs /proc/mounts | cut -f2 -d' '

Jörn

-- 
Premature optimization is the root of all evil.
-- Donald Knuth
