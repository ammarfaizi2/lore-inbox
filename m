Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTHZUYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTHZUYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:24:03 -0400
Received: from [62.241.33.80] ([62.241.33.80]:51205 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262166AbTHZUYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:24:01 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH 2.4.23-pre1] /proc/ikconfig support
Date: Tue, 26 Aug 2003 22:23:08 +0200
User-Agent: KMail/1.5.3
Cc: lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <willy@w.ods.org>
References: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0308261629400.18109@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308262223.08827.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 August 2003 21:33, Marcelo Tosatti wrote:

Hi Marcelo,

> > I have the same question about the seq_file "single" additions
> > patch that I sent yesterday.... ???
> The seq_file patch needs EXPORT_SYMBOL right?

I've send the export_symbol patch yesterday to you cc'ed lkml and randy etc.

> And about ikconfig, hum, I'm not sure if I want that. Its nice, yes, but I
> still wonder. You are free to convince me though: I think people usually
> know what they compile in their kernels, dont they?

grmpf. Absolutely wrong argumentation. People like me compile kernels a lot, 
for tons of different machines, for customers and so on. My brain is not that 
good that I'll remember each and every customers kernel/machine config ;)

Many people forget to copy the current .config to somewhere else in /boot or 
such. And I agree 100% with Willy :)

P.S.: Alan planed it for .23-pre1 ;-))

ciao, Marc

