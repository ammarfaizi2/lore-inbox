Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWEAWgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWEAWgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWEAWgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 18:36:06 -0400
Received: from quechua.inka.de ([193.197.184.2]:27790 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932293AbWEAWgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 18:36:05 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Open Discussion, kernel in production environment
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <200605012357.48623.marcin.hlybin@swmind.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fagzr-0003cG-00@calista.inka.de>
Date: Tue, 02 May 2006 00:36:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Hlybin <marcin.hlybin@swmind.com> wrote:
> I always configure and compile a kernel throwing out all unusable options and 
> I never use modules in production environment (especially for the router). 
> But my superior has got the other opinion - he claims that distribution 
> kernel is quite good and in these days optimization has no sense because of 
> powerful hadrware. 

I think it is most often wasted time to optimize your kernels that way,
especially if you consider the ongoing work you have to put into maintenance
of it.

So unlike you plan to roll out hundreds of systems with the same image
(containing a hand made kernel) I would not suggest to do it.

Of course I am not talking about embedded systems here. For larger Servers
(NUMA, Terrayte Ram stuff like that) I also would think you might want to go
with the Vendor kernel, for better support.

For production use with things like Oracle or SAP, I would suggest to not
use uncertified kernels anyway.

Gruss
Bernd
