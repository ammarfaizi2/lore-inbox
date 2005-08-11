Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVHKTXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVHKTXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVHKTXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:23:50 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:54187 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S932406AbVHKTXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:23:49 -0400
Date: Thu, 11 Aug 2005 22:23:47 +0300
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: fcntl(F_GETLEASE) semantics??
Message-ID: <20050811192347.GG31158@jolt.modeemi.cs.tut.fi>
References: <20050811184144.GE31158@jolt.modeemi.cs.tut.fi> <1123786619.7095.47.camel@lade.trondhjem.org> <20050811190252.GF31158@jolt.modeemi.cs.tut.fi> <1123787745.7095.53.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1123787745.7095.53.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 03:15:45PM -0400, Trond Myklebust wrote:
> The difference between inotify and leases is, as I said, that leases
> notify the lease holder synchronously. This allows the notified process
> to flush all the cached information _before_ the operation that
> triggered the lease notification is executed.

So you're talking about the kernel side.. I was talking about userspace 
perspective on the syscall. It would be rather odd to let a syscall
block other applications involuntarily (and thus achieving synchronous 
action in your meaning)..

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
