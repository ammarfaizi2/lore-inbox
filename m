Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVJZBiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVJZBiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 21:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbVJZBiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 21:38:55 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:45739 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932517AbVJZBiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 21:38:54 -0400
Subject: Re: [ckrm-tech] Re: [PATCH 00/02] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <20051026012216.GD5856@shell0.pdx.osdl.net>
References: <1130285260.10680.194.camel@stark>
	 <20051026003430.GA27680@kroah.com> <1130288437.10680.236.camel@stark>
	 <20051026012216.GD5856@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 18:30:33 -0700
Message-Id: <1130290233.10680.262.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 18:22 -0700, Chris Wright wrote:
> * Matt Helsley (matthltc@us.ibm.com) wrote:
> > 	This patch does not affect whether or not these operations succeed and
> > hence is a poor match for LSM even though it hooks into the same places
> > in the kernel.
> 
> That's correct.  There's no access control happening here, so it's a
> poor fit.  There's all that ELSA, PAGG, CKRM, etc that want this kind of
> stuff.  I'd recommended numerous times to find a common piece for those
> users.
> 
> thanks,
> -chris

	It seems to me that this is the consensus here and on LSE-Tech.
This patch addresses the needs of ELSA and CKRM and is amenable to using
the patches recently proposed on lse-tech to pull out the common piece.

Cheers,
	-Matt Helsley	

