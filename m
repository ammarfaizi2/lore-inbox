Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262432AbVCDFdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbVCDFdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVCDFdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:33:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39865 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262152AbVCDFcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:32:32 -0500
Date: Fri, 4 Mar 2005 00:32:20 -0500
From: Dave Jones <davej@redhat.com>
To: Christophe Lucas <clucas@rotomalug.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 compilation problem.
Message-ID: <20050304053220.GB4625@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christophe Lucas <clucas@rotomalug.org>,
	linux-kernel@vger.kernel.org
References: <20050303193933.GA10709@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303193933.GA10709@rhum.iomeda.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 08:39:33PM +0100, Christophe Lucas wrote:
 > Hi,
 > 
 > Sorry if I waste your time, but I would recompile my kernel with this
 > version, and when it was time to DRM, compilation dead.
 > Perhaps I say mistakes, but it seems drivers/char/drm/gamma.h is not
 > present, which is needed by other parts such as gamma_drv.c
 > 
 > Perhaps, it is my .config which is faulty :-( if it is : sorry.
 >  ...
 > CONFIG_BROKEN=y
 > CONFIG_BROKEN_ON_SMP=y

You told the kernel to try and compile broken drivers.
They broke. End of story.

		Dave

