Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSJ3Pte>; Wed, 30 Oct 2002 10:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264711AbSJ3Pte>; Wed, 30 Oct 2002 10:49:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47929 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264688AbSJ3Pte>; Wed, 30 Oct 2002 10:49:34 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: kexec for 2.5.44 (Who do I send this to?)
References: <m1y98uyc1a.fsf@frodo.biederman.org>
	<20021020190939.GA913@elf.ucw.cz> <m1wuo3kc9r.fsf@frodo.biederman.org>
	<m1r8ebjy14.fsf@frodo.biederman.org>
	<20021030140238.GE12540@atrey.karlin.mff.cuni.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Oct 2002 08:53:33 -0700
In-Reply-To: <20021030140238.GE12540@atrey.karlin.mff.cuni.cz>
Message-ID: <m1vg3jhqiq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > [snip] discussion on how to model IOAPIC and pic and cpus using
> > the device model.
> > 
> > I now need to go code this thing don't I?  Or did I get lucky
> > and get you interested Pavel?
> 
> I'm not sure if putting APICS above PCI will look right to
> Patrick... You'd better ask him. (Sorry, I was offline for > week.)

Ok I will.  I primarily meant to put an APIC bus above pci.  And maybe
filter the APICS down.  The real challenge is that the APIC connection is
in parallel with the PCI connection.  It would take a DAG to truly model
the connections between hardware, and I have been told that people don't want that...

Eric
