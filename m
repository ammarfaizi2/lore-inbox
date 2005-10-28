Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbVJ2ADj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbVJ2ADj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVJ2ADj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:03:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:5799 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750861AbVJ2ADi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:03:38 -0400
Subject: Re: [PATCH] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Jay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
In-Reply-To: <1130541585.10680.846.camel@stark>
References: <1130489713.10680.685.camel@stark>
	 <1130541585.10680.846.camel@stark>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 16:56:31 -0700
Message-Id: <1130543791.10680.853.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I wasn't as thorough as I had hoped re: 64-bit kernel/32-bit
userspace. The uid_t and gid_t types appear to present a problem to the
following:

User  <-> Kernel
i386  <-> x86_64/IA64
sparc <-> sparc64
s390  <-> s390x

:(

	I'll look at this some more and see if I need to resubmit. Until then
I'll hold off on my request for inclusion in -mm.

Cheers,
	-Matt Helsley

