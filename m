Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWFTQM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWFTQM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWFTQM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:12:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15792 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751368AbWFTQM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:12:56 -0400
Date: Tue, 20 Jun 2006 18:12:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matthew Wilcox <matthew@wil.cx>
cc: Matt LaPlante <laplam@rpi.edu>, "'Linus Torvalds'" <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
In-Reply-To: <20060620160128.GL1630@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0606201809100.17704@scrub.home>
References: <Pine.LNX.4.64.0606201742280.12900@scrub.home>
 <000601c69481$a9f86c40$fe01a8c0@cyberdogt42> <20060620160128.GL1630@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Jun 2006, Matthew Wilcox wrote:

> On Tue, Jun 20, 2006 at 11:53:24AM -0400, Matt LaPlante wrote:
> > > How likely is it that someone who doesn't understand the question needs
> > > this option? I think N is a safe answer here.
> > 
> > This is the impression I had as well.  Even if you disagree though, I was
> > equally confused by the fact that if we say to answer Y as default, why is
> > the kconfig default already N?
> 
> The *default* is N as that's the answer most people want.  The *safe*
> answer is Y as it won't prevent you from getting access to your data.
> Makes sense?

This would imply that most people with 32bit systems have 2TB files, which 
I think is rather unlikely. Distributions can turn this option on, but I 
think people who compile their own kernel, either understand this option 
or don't need it.

bye, Roman
