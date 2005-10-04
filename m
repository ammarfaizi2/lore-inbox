Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVJDReJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVJDReJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVJDReI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:34:08 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:5020 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S932523AbVJDReI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:34:08 -0400
Date: Tue, 4 Oct 2005 19:34:06 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 in-kernel file opening
In-Reply-To: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
Message-ID: <Pine.LNX.4.60.0510041933310.8210@kepler.fjfi.cvut.cz>
References: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, Martin Drab wrote:

> Hi,
> 
> can anybody tell me why there is no sys_open() exported in kernel/ksyms.c 
> in 2.4 kernels while the sys_close() is there? And what is then the 
> preferred way of opening files from within a 2.4 kernel module?

Is it just pure filp_open()/filp_close() ?

Martin
