Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVCOTrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVCOTrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVCOTiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:38:50 -0500
Received: from simmts8.bellnexxia.net ([206.47.199.166]:30434 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261803AbVCOTg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:36:57 -0500
Message-ID: <4110.10.10.10.24.1110915247.squirrel@linux1>
In-Reply-To: <20050315190847.GA1870@isilmar.linta.de>
References: <20050315170834.GA25475@kroah.com>
    <20050315190847.GA1870@isilmar.linta.de>
Date: Tue, 15 Mar 2005 14:34:07 -0500 (EST)
Subject: Re: [RFC] Changes to the driver model class code.
From: "Sean" <seanlkml@sympatico.ca>
To: "Dominik Brodowski" <linux@dominikbrodowski.net>
Cc: "Greg KH" <greg@kroah.com>, linux-kernel@vger.kernel.org,
       "Kay Sievers" <kay.sievers@vrfy.org>
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, March 15, 2005 2:08 pm, Dominik Brodowski said:

> For example, temperature sensors could be exported
> using /sys/class/temp_sensors/... -- then userspace wouldn't need to know
> whether the temperature was determined using an ACPI BIOS call or by
> accessing an i2c device. Such "abstractions", and other kernel code whcih
> uses these "abstractions" (a.k.a. class interfaces) are a great feature
> to have, and one too less used by now.

That really sounds like a job for user space, why complicate the kernel?  
A simple user space library could handle returning temperatures without
the caller knowing from where the value was obtained.   Isn't this the
exact type of thing that just bloats a kernel needlessly?

Sean


