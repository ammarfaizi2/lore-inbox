Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWBGRX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWBGRX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWBGRX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:23:28 -0500
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:47490 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932153AbWBGRX1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:23:27 -0500
X-IronPort-AV: i="4.02,95,1139205600"; 
   d="scan'208"; a="377018045:sNHT1166162442"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Date: Tue, 7 Feb 2006 11:23:22 -0600
Message-ID: <35C9A9D68AB3FA4AB63692802656D9EC9277C6@ausx3mps303.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Thread-Index: AcYsCs0yz+s5DdOYTeivuGKmzFpHWwAABRAw
From: <Michael_E_Brown@Dell.com>
To: <mjg59@srcf.ucam.org>
Cc: <akpm@osdl.org>, <Matt_Domsch@Dell.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Feb 2006 17:23:22.0705 (UTC) FILETIME=[3250B410:01C62C0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the list of things to do is called the token table. I am working on
getting permission to release it. As it is, I am releasing tokens as
people ask for them, on a case by case basis.

I, personally, do not build or design our laptops, nor do I have any
sway with those that do. Crying about it isn't going to help, sorry.

If you would care to move the discussion to libsmbios-devel, I would be
more than happy to help you get the token you need and write a
util/lib/whatever to do what you need.
--
Michael 

-----Original Message-----
From: Matthew Garrett [mailto:mjg59@srcf.ucam.org] 
Sent: Tuesday, February 07, 2006 11:20 AM
To: Brown, Michael E
Cc: akpm@osdl.org; Domsch, Matt; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness
display

On Tue, Feb 07, 2006 at 10:34:31AM -0600, Michael_E_Brown@Dell.com
wrote:
> You can get and set laptop brighness on Dell with the proper SMI call.

Oh, heavens. Could you people (and here I include pretty much everyone
who manufactures laptops) please (please!) just implement the ACPI video
extension? We're going to end up having to ship a 200K library for each
and every laptop manufacturer who's decided to implement basic
functionality in a proprietary manner, and it's going to make me cry.

(Which SMI do I need for brightness control? The libsmbios docs seem to
be remarkably quiet on what functionality is actually available, and I'm
not keen on calling things randomly :))

--
Matthew Garrett | mjg59@srcf.ucam.org
