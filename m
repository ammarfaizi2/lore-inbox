Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTJ0XUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTJ0XUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:20:09 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:54534 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263763AbTJ0XUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:20:06 -0500
Subject: Re: test9 suspend problems
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: David Ford <david+powerix@blue-labs.org>, John Mock <kd6pag@qsl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310271352560.13116-100000@cherise>
References: <Pine.LNX.4.44.0310271352560.13116-100000@cherise>
Content-Type: text/plain
Message-Id: <1067296799.1776.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 28 Oct 2003 00:19:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-27 at 22:53, Patrick Mochel wrote:
> > Unfortunately I use USB mostly for my digital camera.  Losing sound is 
> > pretty annoying too because everything that tries to play sound then 
> > gets into D state as well.
> 
> That would most likely be due to your sound driver not supporting 
> suspend/reusme. Which sound driver are you using? 

What about ALSA Yamaha YMFPCI sound driver? I need to unload it before
suspending.

