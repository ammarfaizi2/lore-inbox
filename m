Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVCVMcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVCVMcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 07:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCVMcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 07:32:09 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:38043 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261174AbVCVMb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 07:31:56 -0500
Date: Tue, 22 Mar 2005 13:18:10 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
Message-ID: <20050322121810.GB18889@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
References: <20050321154226.19053.36781.35540@clementine.local> <20050322025104.GA18067@linuxtv.org> <aec7e5c3050322000677d5f22f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c3050322000677d5f22f@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.231.45.50
Subject: Re: [PATCH] dvb_frontend: MODULE_PARM_DESC
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 09:06:29AM +0100, Magnus Damm wrote:
> On Tue, 22 Mar 2005 03:51:04 +0100, Johannes Stezenbach <js@linuxtv.org> wrote:
> > On Mon, Mar 21, 2005 at 05:10:27PM +0100, Magnus Damm wrote:
> > > Remove "dvb_"-prefix from parameters. Without the patch all parameters except
> > > the declaration of parameter "frontend_debug" have a "dvb_"-prefix.
> > 
> > Why is that dvb_ prefix a problem?
> 
> It is no biggie and probably not worth breaking users' configuration
> like you said, but most drivers do not have their KBUILD_MODNAME
> included in the parameter names.
> 
> Setting parameters that have KBUILD_MODNAME as prefix from the kernel
> commandline is then done by KBUILD_MODNAME.KBUILD_MODNAME_xxx and that
> is plain ugly - especially when a list of parameters are generated
> from the source.
> Some bad citizens IMO:
> 
> dvb.dvb_shutdown_timeout, asus.asus_gid, arlan.arlan_entry_debug

I agree it's ugly. For now it's better not to touch them anyway.

Johannes
