Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSKRRm1>; Mon, 18 Nov 2002 12:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSKRRm1>; Mon, 18 Nov 2002 12:42:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1555 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263899AbSKRRm1>;
	Mon, 18 Nov 2002 12:42:27 -0500
Message-ID: <3DD92808.6050208@pobox.com>
Date: Mon, 18 Nov 2002 12:48:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Knigge <Michael.Knigge@set-software.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.xx: 8139 isn't working
References: <20021118.10200352@knigge.local.net>
In-Reply-To: <20021118.10200352@knigge.local.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

As was mentioned by another poster, UP IOAPIC is very likely the problem 
suspect here, but ACPI is also a possibility.

Booting with "noapic" or changing your BIOS to "MP 1.1" instead of "MP 
1.4" will likely solve the problem.

If that doesn't not solve the problem, try disabling ACPI in your 
kernel's config.

Please let us know if either of these solutions works for you!

thanks and regards,

	Jeff



