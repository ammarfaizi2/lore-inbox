Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTKCVMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 16:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTKCVMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 16:12:47 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:5863 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263386AbTKCVMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 16:12:45 -0500
Date: Mon, 3 Nov 2003 22:12:41 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland?
Message-ID: <20031103211241.GN16820@louise.pinerecords.com>
References: <20031103193940.GA16820@louise.pinerecords.com> <Pine.LNX.4.53.0311031519050.2654@chaos> <20031103204118.GJ16820@louise.pinerecords.com> <20031103220006.A21093@electric-eye.fr.zoreil.com> <20031103220357.A22860@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031103220357.A22860@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov-03 2003, Mon, 22:03 +0100
Francois Romieu <romieu@fr.zoreil.com> wrote:

> Francois Romieu <romieu@fr.zoreil.com> :
> [...]
> > Hack sysvinit/shutdown.c so that it exec /sbin/telinit U and put the adequate
> > command in /etc/inittab ?
> 
> Won't work: init keeps "did_boot" in its state.

Maybe also hack a new "telinit R" option that would clear the flag?

-- 
Tomas Szepe <szepe@pinerecords.com>
