Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTL2NAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 08:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTL2NAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 08:00:02 -0500
Received: from as1-6-4.ld.bonet.se ([194.236.130.199]:1920 "HELO mail.nicke.nu")
	by vger.kernel.org with SMTP id S263325AbTL2M77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:59:59 -0500
From: "Nicklas Bondesson" <nicke@nicke.nu>
To: <arjanv@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: ataraid in 2.6.?
Date: Mon, 29 Dec 2003 13:59:59 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1072691350.5223.7.camel@laptop.fenrus.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPN8US0Q0fPFnF0Rvy7wlQRKkySxQAGeZ4w
Message-Id: <S263325AbTL2M77/20031229125959Z+17655@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so the ataraid framework will not be ported at all tp 2.6.x, it will be
replaced with a device mapper?

Where could one read more about the device mapper?

I'm currently running RAID1 using ataraid on a Promise TX2000 card using the
2.4.23 kernel (patched with Walt H's pdcraid patch set to the list
yesterday).

/Nicke

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Arjan van de Ven
Sent: den 29 december 2003 10:49
To: Nicklas Bondesson
Cc: linux-kernel@vger.kernel.org
Subject: Re: ataraid in 2.6.?

On Mon, 2003-12-29 at 01:09, Nicklas Bondesson wrote:
> Hi!
> 
> Is the ataraid framework planned to be ported to 2.6.x? If so, when 
> could one expect it?

the plan is to have a userspace device mapper app take it's place.
As for the timeframe; I'm looking at it but the userspace device mapper code
is still a bit of a mystory to me right now.

