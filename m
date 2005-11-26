Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbVKZDwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbVKZDwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 22:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVKZDwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 22:52:04 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:33976 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932713AbVKZDwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 22:52:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Entering BIOS on DELL mobiles - does the kernel prohibit?
Date: Fri, 25 Nov 2005 22:51:57 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <20051123155319.GA6970@stiffy.osknowledge.org> <200511232057.44022.dtor_core@ameritech.net> <20051124085018.GB7799@stiffy.osknowledge.org>
In-Reply-To: <20051124085018.GB7799@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511252251.58027.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 03:50, Marc Koschewski wrote:
> * Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-23 20:57:43 -0500]:
> 
> > On Wednesday 23 November 2005 10:53, Marc Koschewski wrote:
> > > Hi all,
> > > 
> > > first of all, if someone could point me to some information on that
> > > topic, I would be glad. I didn't find anything on Google.
> > > 
> > > The 'problem' is: I remember being able to enter the DELL Inspiron BIOS
> > > from a running X session (or console) some (long) time ago. I just noticed,
> > > it no longer works. Does the kernel somehow prohibit to enter the BIOS
> > > or does the laptop itself stop from doing so (maybe due to a BIOS update).
> > >
> > 
> > It is only pssible with APM. ACPI "kills" it.
> 
> Oh! I didn't know. Is there any good reason to do so? I mean, any device
> change (ie. serial port re-configuration) is just valid from next reboot, thus
> not affecting the running kernel. Am I missing something?
>

ACPI takes control over entire box, from that point on you can't enter
pretty much any BIOS code. FWIW one ACPI is active it does not work in
Windows either.

-- 
Dmitry
