Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVATVOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVATVOm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVATVMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:12:47 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:23559 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S261973AbVATVMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:12:18 -0500
Date: Thu, 20 Jan 2005 21:12:14 +0000
From: John Levon <levon@movementarian.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] unexport profile_pc
Message-ID: <20050120211214.GA75899@compsoc.man.ac.uk>
References: <20050120182019.GJ3174@stusta.de> <Pine.LNX.4.61.0501201216420.16780@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501201216420.16780@montezuma.fsmlabs.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Graham Coxon - Happiness in Magazines
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CrjbD-000EKx-1e*opZjAOoIbak*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 12:16:52PM -0700, Zwane Mwaikambo wrote:

> > I haven't found any modular usage of profile_pc in the kernel.
> 
> Oprofile?

We don't actually use it, but it looks like maybe we should? It seems
unfortunate that readprofile and OProfile should disagree here.

john
