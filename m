Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbTLBNtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTLBNtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:49:20 -0500
Received: from dsl.amelek.gda.pl ([80.53.220.6]:62413 "EHLO alf.amelek.gda.pl")
	by vger.kernel.org with ESMTP id S262098AbTLBNtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:49:00 -0500
Date: Tue, 2 Dec 2003 14:48:51 +0100
To: Ed Vance <EdV@macrolink.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       "'Russell King'" <rmk@arm.linux.org.uk>
Subject: Re: 2.4.x parport_serial link order bug (only works as a module)
Message-ID: <20031202134851.GA6658@amelek.gda.pl>
References: <11E89240C407D311958800A0C9ACF7D1A34047@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A34047@EXCHANGE>
User-Agent: Mutt/1.5.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 20, 2003 at 10:09:39AM -0800, Ed Vance wrote:
> 
> I think it should go into 2.4. It fixes this particular ordering issue
> without mucking about with the ordering mechanism or even adding code. I'm
> sorry to say that I had forgotten about it. It's a good minimum-change
> brute-force umm... solution. No bloat or complexity issues. 
> 
> At your convenience, please move the parport_serial.c file and apply the
> corresponding Makefile changes. 

Now that 2.4.23 is out, could you try to help me getting this (and
possibly NetMos changes) into 2.4.24?  I've just read that 2.4.24
is the last release for which new drivers are accepted, and it's
not even a new driver...  Tim Waugh has been silent about NetMos
problems, and the current version of my patch (made for 2.4.21,
but should apply cleanly to 2.4.23) makes NetMos support a config
option, conditional on CONFIG_EXPERIMENTAL.

Thanks,
Marek

