Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266533AbSKGM7j>; Thu, 7 Nov 2002 07:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266534AbSKGM7j>; Thu, 7 Nov 2002 07:59:39 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:15358 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266533AbSKGM7i>; Thu, 7 Nov 2002 07:59:38 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <1036340733.29642.41.camel@irongate.swansea.linux.org.uk> 
References: <1036340733.29642.41.camel@irongate.swansea.linux.org.uk>  <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021103145735.14872@smtp.wanadoo.fr> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: benh@kernel.crashing.org, Alan Cox <alan@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Nov 2002 13:06:02 +0000
Message-ID: <2117.1036674362@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> The bigger picture really should be
>  ACPI etc	"I want to suspend to disk" 

Er, what?

The 'I want to suspend to disk' instruction comes from the generic PM code 
too, surely? ACPI just registers a handful of methods with the generic PM 
code for actually doing stuff like entering sleep states, etc.

--
dwmw2


