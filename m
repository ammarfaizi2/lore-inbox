Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWJHVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWJHVAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWJHVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 17:00:14 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:20046 "EHLO
	outbound1-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751399AbWJHVAM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 17:00:12 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: Please pull x86-64 bug fixes
Date: Sun, 8 Oct 2006 15:59:56 -0500
Message-ID: <1449F58C868D8D4E9C72945771150BDF46F9B5@SAUSEXMB1.amd.com>
In-Reply-To: <Pine.LNX.4.64.0610061912460.3952@g5.osdl.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: Please pull x86-64 bug fixes
Thread-Index: AcbptzVKZr/QTWOTQVK1YKiA+ZcVGQBYpwEg
From: "Duran, Leo" <leo.duran@amd.com>
To: "Linus Torvalds" <torvalds@osdl.org>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Jeff Garzik" <jeff@garzik.org>, "Andi Kleen" <ak@suse.de>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 08 Oct 2006 20:59:56.0081 (UTC)
 FILETIME=[B559CA10:01C6EB1C]
X-WSS-ID: 6937B9461L85311740-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2006, Linus Torvalds wrote:

>On Fri, 6 Oct 2006, Duran, Leo wrote:
>> So, one can argue that there's merit on having ACPI
>
>Not really.
>
>The thing is, you have two choices:
> - define interfaces in hardware
> - not doing so, and then trying to paper it over with idiotic tables.

I would have to agree that having HW describe itself makes sense, and
would certainly negate the need for 'static' ACPI tables that attempt
doing that.

But, allow me to cite another example to reinforce my point about the
merit of ACPI: Staying with processor power management interfaces, how
about 'dynamic' interfaces such as _PPC? _PPC describes to the OS the
platform's desired behavior based on some event, like unplugging the
power-cord on a laptop - I find merit on that kind of platform-to-OS
communication mechanism (I don't like the idea of having the platform
making decisions & taking actions behind the OS's back... and even if it
had to, I like the idea of at least providing some kind of notification,
which is possible via ACPI interfaces).

Leo Duran.


