Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUCWLi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbUCWLi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:38:56 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:24743 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S262498AbUCWLiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:38:55 -0500
Date: Tue, 23 Mar 2004 12:38:23 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Mauro Stettler <kernel-list@bluesaturn.com>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: cannot compile
Message-ID: <20040323113823.GB16605@localhost>
References: <1080048426.6447.6.camel@twinmos.bluesaturn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1080048426.6447.6.camel@twinmos.bluesaturn.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 23rd 2004 Mauro Stettler wrote:

> ...
> include/linux/kernel.h:10:20: stdarg.h: No such file or directory

There's something wrong with your gcc installation. It has nothing to do
with the kernel compilation perse.

stdarg.h is a part of the headers that are specific to each gcc version.
You'll normally find it somewhere below /usr/lib/gcc-lib.

Perhaps something went wrong during installation of your gcc (a full
disk or so) or you moved some directory trees, causing gcc no longer to
find its include files. Some directories are hardcoded into the gcc
executable during its compilation. If you have to move some things (to
work around full partitions say) use symlinks.

Try reinstalling gcc.
-- 
Marco Roeland
