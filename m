Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbUJ1MYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbUJ1MYg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbUJ1MYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:24:34 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:12939 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262988AbUJ1MVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:21:07 -0400
Message-ID: <4180E430.70800@dgreaves.com>
Date: Thu, 28 Oct 2004 13:21:04 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Giuliano Pochini <pochini@denise.shiny.it>,
       Timothy Miller <miller@techsource.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <1098442636l.17554l.0l@hh> <20041025152921.GA25154@thundrix.ch> <417D216D.1060206@techsource.com> <Pine.LNX.4.58.0410251825480.16966@denise.shiny.it> <20041028093752.GB13523@hh.idb.hist.no>
In-Reply-To: <20041028093752.GB13523@hh.idb.hist.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

>Or one could go the other way - if we use 32 bits, then
>consider 10 bits per color.  I've always wondered about the purpose
>of a 8-bit alpha channel.  what exactly is supposed to show
>in "transparent" places?  Transparency makes sense when talking about 
>windows - you see the underlying window through a transparent spot.
>But this is the frame buffer we're talking about - what is
>supposed to be behind that?  Another frame buffer?
>  
>
Well, The Hauppage 350 via the ivtv driver provides a framebuffer 'OSD' 
(On Screen Display) that overlays the hardware video (as in TV) layer.
Transparency determines how much of the video shows through.

It's good having a framebuffer that can run X (or whatever) overlayed 
onto the video stream.

David
