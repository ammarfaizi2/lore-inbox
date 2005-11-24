Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030627AbVKXIt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030627AbVKXIt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbVKXIt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:49:59 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:5825 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1030629AbVKXIt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:49:58 -0500
Date: Thu, 24 Nov 2005 09:50:18 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Entering BIOS on DELL mobiles - does the kernel prohibit?
Message-ID: <20051124085018.GB7799@stiffy.osknowledge.org>
References: <20051123155319.GA6970@stiffy.osknowledge.org> <200511232057.44022.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511232057.44022.dtor_core@ameritech.net>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dtor_core@ameritech.net> [2005-11-23 20:57:43 -0500]:

> On Wednesday 23 November 2005 10:53, Marc Koschewski wrote:
> > Hi all,
> > 
> > first of all, if someone could point me to some information on that
> > topic, I would be glad. I didn't find anything on Google.
> > 
> > The 'problem' is: I remember being able to enter the DELL Inspiron BIOS
> > from a running X session (or console) some (long) time ago. I just noticed,
> > it no longer works. Does the kernel somehow prohibit to enter the BIOS
> > or does the laptop itself stop from doing so (maybe due to a BIOS update).
> >
> 
> It is only pssible with APM. ACPI "kills" it.

Oh! I didn't know. Is there any good reason to do so? I mean, any device
change (ie. serial port re-configuration) is just valid from next reboot, thus
not affecting the running kernel. Am I missing something?

Marc
