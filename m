Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270148AbTGZP2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270140AbTGZPZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:25:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:57526 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270164AbTGZPXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:23:00 -0400
Date: Sat, 26 Jul 2003 21:08:11 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Random Oopses on 2.6.0-test1-mm2
Message-ID: <20030726153811.GC1327@home.woodlands>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030726071801.GB1358@home.woodlands> <1059209649.577.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059209649.577.4.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> [26-07-2003 14:44]:
> On Sat, 2003-07-26 at 09:18, Apurva Mehta wrote:
> > Hi, 
> > 
> > I get random oopses while using 2.6.0-test1-mm2. I have attached the
> > oops message and also the ksymoops output. I get the same behaviour
> > with the 08int patch applied also. The OOPs message attached was
> > obtained on a 2.6.0-test1-mm2-08int.
> 
> Please, try the following patch...

Yes, that seems to have fixed the problem. So far, I see a definite
improvement over the vanilla 2.6.0-test1. 

But Ingo's patch made the vanilla 2.6.0-test1 awesome under really
heavy load. I basically was compiling 2.6.0-test1-mm2-O8 from scratch
and the system was (almost) as responsive as if there was no load, with
no audio skipping. That was the first real improvement I have seen
over the vanilla 2.4.21... Will keep you'll posted at how
2.6.0-test1-mm2-O8int compares..

	- Apurva
