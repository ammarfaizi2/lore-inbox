Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262883AbSJBBKO>; Tue, 1 Oct 2002 21:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbSJBBKO>; Tue, 1 Oct 2002 21:10:14 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:30199 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262883AbSJBBKN>; Tue, 1 Oct 2002 21:10:13 -0400
Subject: Re: cpufreq patches for 2.5.39 follow
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Dominik Brodowski <linux@brodo.de>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       hpa@zytor.com, cpufreq@www.linux.org.uk
In-Reply-To: <20020930023850.E35@toy.ucw.cz>
References: <20020928112130.A1217@brodo.de>  <20020930023850.E35@toy.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 02:22:50 +0100
Message-Id: <1033521770.20081.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 03:38, Pavel Machek wrote:
> How does it interact with ACPI? Ie. I do echo "100%100%foo", but ACPI thermal
> managment decides to slow down?

In an ACPI world you probably want ACPI to do the kernel requests to set
the policy not diddle it by hand. "native power control" or whatever
ACPI calls 'not using ACPI' 8)

> > Support for mobile AMD K7 processors is still in development.
> 
> What about mobile celerons?

Intel support is poor. Intel have been *extremely* difficult about
speedstep, no documentation, no help, no good explanation of why they
are being a pain either. That there is any speedstep support is thanks
to a lot of work by the cpufreq folks.

Alan

