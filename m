Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSGRPnv>; Thu, 18 Jul 2002 11:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318146AbSGRPnv>; Thu, 18 Jul 2002 11:43:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20805 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318145AbSGRPnt>; Thu, 18 Jul 2002 11:43:49 -0400
To: Thunder from the hill <thunder@ngforever.de>
Cc: Hell.Surfers@cwctv.net, hahn@physics.mcmaster.ca,
       <linux-kernel@vger.kernel.org>
Subject: Re: how to improve the throughput of linux network
References: <Pine.LNX.4.44.0207152055080.3452-100000@hawkeye.luckynet.adm>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Jul 2002 09:35:13 -0600
In-Reply-To: <Pine.LNX.4.44.0207152055080.3452-100000@hawkeye.luckynet.adm>
Message-ID: <m1ele1nj66.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill <thunder@ngforever.de> writes:

> Hi,
> 
> On Tue, 16 Jul 2002 Hell.Surfers@cwctv.net wrote:
> > well only if it was used little amounts, like once every hour, it would
> > dynamically unload in between,
> 
> That's ok then. It shouldn't produce significant overhead. But on the 
> routers that I run I have either no netfilters at all, or they keep 
> running, so even if they were a module, they'd never have any time to 
> unload.

Only if you have a cron job running rmmod -a will the module unload.
The kernel never unloads modules without being asked.

Eric
