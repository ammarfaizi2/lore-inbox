Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTGBFmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 01:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTGBFmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 01:42:24 -0400
Received: from mta07bw.bigpond.com ([144.135.24.134]:503 "EHLO
	mta07bw.bigpond.com") by vger.kernel.org with ESMTP id S264728AbTGBFmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 01:42:23 -0400
Date: Wed, 02 Jul 2003 15:56:48 +1000
From: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: Re: PROBLEM: USB Serial oops in 2.4.22-pre2
In-reply-to: <20030702033417.GB3272@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <200307021556.48174.harisri@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
References: <200307021222.09764.harisri@bigpond.com>
 <20030702033417.GB3272@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Wednesday 02 July 2003 13:34, Greg KH wrote:
> On Wed, Jul 02, 2003 at 12:22:09PM +1000, Srihari Vijayaraghavan wrote:
> > [1.] One line summary of the problem:
> > USB Serial oops in 2.4.22-pre2
>
> Does this happen with 2.4.21?

I do not know. I'll try to test it under 2.4.21 (ie, 2.4.21 + ACPI as USB 
won't work without ACPI on ATI-IGP+ALi combo, like my laptop. And that's a 
primary reason behind using 2.4.22-pre as ACPI is in the official 2.4 tree).

>
> Anyway, this is a known bug.  See the linux-usb-devel archives for what
> needs to be done to fix this, or just switch to 2.5, as it's fixed there
>
> :)

Unfortunately that isn't an option, as this is my production environment 
(incidentally I've used 2.5 in the past, but as you know 2.4 is the stable 
tree and is the most appropriate one).

I'm now searching the usb-devel archives to understand this issue, but do you 
think the upcoming 2.4.22-pre3 might fix this issue?

Thanks for your response :).
-- 
Hari

