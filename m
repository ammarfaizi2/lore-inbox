Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUBJTxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUBJTv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:51:28 -0500
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:7092 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266205AbUBJTs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:48:58 -0500
Date: Tue, 10 Feb 2004 13:48:55 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: psmouse.c, throwing 3 bytes away
Message-ID: <20040210194855.GA10591@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200402041820.39742.wnelsonjr@comcast.net> <200402060006.32732.wnelsonjr@comcast.net> <20040207004700.0dd5e626.mikeserv@bmts.com> <200402070911.42569.murilo_pontes@yahoo.com.br> <20040209004812.GA18512@ucw.cz> <20040210025627.GA2117@yggdrasil.localdomain> <20040210070735.GA257@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210070735.GA257@ucw.cz>
X-Operating-System: Linux yggdrasil 2.6.2 #1 SMP Mon Feb 9 21:16:57 CST 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 08:07:35AM +0100, Vojtech Pavlik wrote:
> USB?? This was for PS/2 mice. If it fixed your USB mouse problem, you
> were using PS/2 drivers with your USB mouse, which is wrong (although it
> can work). You need to use USB drivers.

I thought I was... all of the appropriate USB drivers are enabled, and
I haven't done anything special to load the psmouse module.  I guess
it's possible that a bootup script is loading it automagically,
tho.  I'll check into this.
