Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVJZB25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVJZB25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 21:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVJZB25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 21:28:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932515AbVJZB24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 21:28:56 -0400
Date: Tue, 25 Oct 2005 18:22:16 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20051026012216.GD5856@shell0.pdx.osdl.net>
References: <1130285260.10680.194.camel@stark> <20051026003430.GA27680@kroah.com> <1130288437.10680.236.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130288437.10680.236.camel@stark>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Helsley (matthltc@us.ibm.com) wrote:
> 	This patch does not affect whether or not these operations succeed and
> hence is a poor match for LSM even though it hooks into the same places
> in the kernel.

That's correct.  There's no access control happening here, so it's a
poor fit.  There's all that ELSA, PAGG, CKRM, etc that want this kind of
stuff.  I'd recommended numerous times to find a common piece for those
users.

thanks,
-chris
