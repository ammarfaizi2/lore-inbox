Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272415AbRJCJ27>; Wed, 3 Oct 2001 05:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272244AbRJCJ2j>; Wed, 3 Oct 2001 05:28:39 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:56840 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S272092AbRJCJ2g>;
	Wed, 3 Oct 2001 05:28:36 -0400
Date: Wed, 3 Oct 2001 11:28:55 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
Message-ID: <20011003112855.H574@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20010928160250.K21524@come.alcove-fr> <200110022211.f92MBwE06003@buggy.badula.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200110022211.f92MBwE06003@buggy.badula.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 06:11:58PM -0400, Ion Badulescu wrote:

> > What about making a conditional on 'is_sony_vaio_laptop' here ?
> > (but you need to extends the conditionnal export of this variable 
> > from dmi_scan.c / i386_ksyms.c).
> 
> Well, the funny thing is, the same kernel doesn't boot on a Dell Inspiron 
> laptop either, if PNP is enabled -- and the oops is the same. So it's not 
> just Sony...

Maybe we'll need to test against something like 'pnp_broken' 
variable instead of is_sony_vaio_laptop in PnP drivers, and
add the callbacks in dmi_scan to initialize pnp_broken...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
