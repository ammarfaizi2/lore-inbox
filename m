Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVHKTCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVHKTCz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVHKTCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:02:55 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:18091 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S932369AbVHKTCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:02:54 -0400
Date: Thu, 11 Aug 2005 22:02:52 +0300
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: fcntl(F_GETLEASE) semantics??
Message-ID: <20050811190252.GF31158@jolt.modeemi.cs.tut.fi>
References: <20050811184144.GE31158@jolt.modeemi.cs.tut.fi> <1123786619.7095.47.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1123786619.7095.47.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6+20040907i
From: shd@modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 02:56:59PM -0400, Trond Myklebust wrote:
> inotify does not give you synchronous notification. It just tells you
> something has happened after the fact. Not the same thing at all.

Then what could be done for inotify to fit the purpose? SETLEASE is 
still a bad interface for userspace programs because it relies on 
signals and thus can't be conveniently put into shared libraries..

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
