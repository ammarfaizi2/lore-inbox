Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUCZUXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUCZUXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:23:08 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:6163 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261204AbUCZUXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:23:06 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jeff Garzik <jgarzik@pobox.com>, Andreas Henriksson <andreas@fjortis.info>
Subject: Re: [PATCH] Re: fealnx oopses
Date: Fri, 26 Mar 2004 22:05:53 +0200
User-Agent: KMail/1.5.4
Cc: netdev@oss.sgi.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <200403261214.58127.vda@port.imtp.ilyichevsk.odessa.ua> <20040326192211.GA15319@scream.fjortis.info> <4064857E.2050603@pobox.com>
In-Reply-To: <4064857E.2050603@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403262205.53503.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 March 2004 21:33, Jeff Garzik wrote:
> > Although I now have the myson/fealnx card in my p3-900 (256Mb)
> > workstation instead of the old p-166 (40Mb) which served as a gateway
> > before. It might just be that it's harder to trigger on newer/bigger
> > machines. Maybee I should power up my p-166 again.. I actually have 2 of
> > these cards so I can have one in each machine.. :)
>
> Well really, somebody needs to port Donald Becker's myson driver to 2.6
> APIs...  I would like to get rid of fealnx, or somebody needs to spend a
> decent amount of time fixing it.
>
> Does the attached patch fix the issue?
>
> 	Jeff

It may fix Andreas case, but I doubt it can fix mine -
mine was related to _rx_ code path.

I need to find a way to reliably reproduce oopses with unfixed driver first.
--
vda

