Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVFGNSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVFGNSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVFGNSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:18:39 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:18451 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261856AbVFGNSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:18:08 -0400
Message-ID: <42A6B7B8.90000@rtr.ca>
Date: Wed, 08 Jun 2005 05:17:44 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Michael (Micksa) Slade" <micksa@knobbits.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Inspiron 6000 / ACPI S3 / PCI-X problems?
References: <42A4969D.9070500@knobbits.org>
In-Reply-To: <42A4969D.9070500@knobbits.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael (Micksa) Slade wrote:
> I've been trying desperately to get suspend-to-ram working on my new 
> inspiron 6000.
..
> It's an ATI radeon M300, on a PCI-X bridge I think.

PCI-Express (PCIe), not PCI-X.

> Is this a kernel issue or an X issue?  I vaguely recall some pci config 
> save/restore hack floating around somewhere, should I try that?
> 
> This is ubuntu breezy, using xorg and kernel image 2.6.11.93-1.1

The i6000 is very similar internally (identical?) to the i9300.
I have a Dell Inspiron 9300 and *everything* is working perfectly with Linux,
except for the SD-slot (no driver, no datasheets).

Try my suspend script and other (K)Ubuntu changes:  http://rtr.ca/dell_i9300/

Cheers
