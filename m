Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbVJZAfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVJZAfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 20:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJZAfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 20:35:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:42171 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932507AbVJZAfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 20:35:09 -0400
Date: Tue, 25 Oct 2005 17:34:30 -0700
From: Greg KH <greg@kroah.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Subject: Re: [PATCH 00/02] Process Events Connector
Message-ID: <20051026003430.GA27680@kroah.com>
References: <1130285260.10680.194.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130285260.10680.194.camel@stark>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 05:07:40PM -0700, Matt Helsley wrote:
> Andrew, all,
> 
> 	Is there any reason this patch could not go for a spin in a -mm tree?
> It's similar to Guillaume's fork connector patch which did appear in -mm
> at one point. It replaces the fork_advisor patch that ELSA is currently
> using, can be used by userspace CKRM code, and in general is useful for
> anything that may wish to monitor changes in all processes.

Why can't you use a lsm module for this instead?  It looks like you are
wanting to hook things in pretty much the same places we currently have
the lsm hooks at.

thanks,

greg k-h
