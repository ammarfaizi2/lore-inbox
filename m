Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUFNOJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUFNOJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbUFNOIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:08:37 -0400
Received: from zulo.virutass.net ([62.151.20.186]:45544 "EHLO
	mx.larebelion.net") by vger.kernel.org with ESMTP id S263040AbUFNOI0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:08:26 -0400
From: Manuel Arostegui Ramirez <manuel@todo-linux.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Subject: Re: Local DoS attack on i386 (was: new kernel bug)
Date: Mon, 14 Jun 2004 16:08:16 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200406121159.28406.manuel@todo-linux.com> <1087221517.3375.3.camel@sherbert>
In-Reply-To: <1087221517.3375.3.camel@sherbert>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406141608.16319.manuel@todo-linux.com>
X-Virus: by Larebelion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Lunes 14 Junio 2004 15:58, Gianni Tedesco escribió:
> On Sat, 2004-06-12 at 11:59 +0200, Manuel Arostegui Ramirez wrote:
> > Somebody know a patch to solved this new bug?
> > http://reviewed.homelinux.org/news/2004-06-11_kernel_crash/index.html.en
> > Affected versions:
> >     * Linux 2.6.x
> >           o Linux 2.6.7-rc2
> >           o Linux 2.6.6 (all versions)
> >           o Linux 2.6.6 SMP (verified by riven)
> >           o Linux 2.6.5-gentoo (verified by RatiX)
> >           o Linux 2.6.5-mm6 - (verified by Mariux)
> >     * Linux 2.4.2x
> >           o Linux 2.4.26 vanilla
> >           o Linux 2.4.26-rc1 vanilla
> >           o Linux 2.4.26-gentoo-r1
> >           o Linux 2.4.22
>
> Seems to be a scheduler race or something?

The timer and fpu stuff locks the console race, io-schedules also stops.
This seems serious.
Look at the original thread, it's called:
"timer + fpu stuff locks my console race"
Here you are:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108704334308688&w=2

Cheers

-- 
Manuel Arostegui Ramirez #Linux Registered User 200896

