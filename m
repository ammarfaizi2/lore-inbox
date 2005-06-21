Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVFUNOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVFUNOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVFUNMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:12:52 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:58634 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261389AbVFUNIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:08:41 -0400
Date: Tue, 21 Jun 2005 09:03:19 -0400
From: Jeff Dike <jdike@addtoit.com>
To: XIAO Gang <xiao@unice.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML mode panick under 2.6.12
Message-ID: <20050621130319.GA4510@ccure.user-mode-linux.org>
References: <42B7C0FA.8070409@unice.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B7C0FA.8070409@unice.fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 09:25:46AM +0200, XIAO Gang wrote:
> 
> I am unable to run UML mode (i386) under 2.6.12: the execution gives the 
> following messages.
> 
> ---------------------------------------------------------------------------------------------

> Checking that ptrace can change system call numbers...<0>Kernel panic - 
> not syncing: Segfault with no mm

Can you try backing out the use-fork-instead-of-clone patch?  Ben LaHaise
reported that caused problems for him.

				Jeff
