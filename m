Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTEQTe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 15:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbTEQTeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 15:34:25 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:18832 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261788AbTEQTeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 15:34:25 -0400
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0305171107090.2356-100000@montezuma.mastecende.com>
References: <20030514193300.58645206.akpm@digeo.com>
	 <Pine.LNX.4.44.0305141935440.9816-100000@cherise>
	 <20030514231414.42398dda.akpm@digeo.com>
	 <1053000426.605.4.camel@teapot.felipe-alfaro.com>
	 <Pine.LNX.4.50.0305171107090.2356-100000@montezuma.mastecende.com>
Content-Type: text/plain
Message-Id: <1053200826.586.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 17 May 2003 21:47:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-17 at 21:25, Zwane Mwaikambo wrote:
> On Thu, 15 May 2003, Felipe Alfaro Solana wrote:
> 
> > > In this case we need to understand why the lockup is happening - what
> > > code is requiring 8259 services after the thing has been turned off?
> > > Could be that the bug lies there.
> > > 
> > > Felipe, please send your .config.   (again - in fact you may as well do
> > > cp .config ~/.signature)
> > 
> > Config attached...
> > Don't understand what do you mean with "cp .config ~/.signature" :-?
> > 
> Unable to reproduce, appears to be machine specific, 1 laptop and 2 test 
> systems both managed to power off with APM or ACPI. Also tried with 
> Felipe's config

The machine is a NEC (Packard Bell) Chrom@. Could an lspci be of
interest?

