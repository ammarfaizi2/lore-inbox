Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSK1JK7>; Thu, 28 Nov 2002 04:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbSK1JK7>; Thu, 28 Nov 2002 04:10:59 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:1532 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S265339AbSK1JK6>; Thu, 28 Nov 2002 04:10:58 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to list pci devices from userpace?  anything better than
 /proc/bus/pci/devices?
References: <3DE537FC.6090105@nortelnetworks.com>
X-URL: <http://www.linux-mandrake.com/
Organization: MandrakeSoft
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Date: Thu, 28 Nov 2002 10:18:23 +0100
In-Reply-To: <3DE537FC.6090105@nortelnetworks.com> (Chris Friesen's message
 of "Wed, 27 Nov 2002 16:24:12 -0500")
Message-ID: <m2r8d6aw80.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> I have a situation where the userspace app needs to be able to deal
> with two different models of hardware, each of which uses a slightly
> different api.
> 
> Is there any way that I can query the pci vendor/device numbers
> without having to parse ascii files in /proc?

look at libldetect from ldetect package.

http://cvs.mandrakesoft.com/cgi-bin/cvsweb.cgi/soft/ldetect/

