Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751800AbWIXJCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWIXJCa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 05:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWIXJCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 05:02:30 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:42146 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751800AbWIXJCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 05:02:30 -0400
Date: Sun, 24 Sep 2006 11:07:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Frederik Deweerdt <deweerdt@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Make kernel -dirty naming optional
Message-ID: <20060924090743.GB22731@uranus.ravnborg.org>
References: <20060922120210.GA957@slug> <20060922104933.GA3348@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922104933.GA3348@harddisk-recovery.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:49:34PM +0200, Erik Mouw wrote:
> On Fri, Sep 22, 2006 at 12:02:10PM +0000, Frederik Deweerdt wrote:
> > Could you consider applying this patch (or indicate me a better way to
> > do it). It can be handy to be able to keep the naming independent of
> > git.
> 
> FWIW, if I enable git name tagging, every kernel I compile is tagged as
> "dirty", even if I cloned it directly from kernel.org and didn't make
> any change to the source. That makes the "dirty" tag useless IMHO.

make mrproper
make allmodconfig
make prepare
make kernelrelease 
	2.6.18-ga5fa393b
vi MAINTAINERS
make prepare
make kernelrelease
	2.6.18-ga5fa393b-dirty

So it wrks for me.
Can you provice a few more details what steps you do when you see it failing.

	Sam
