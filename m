Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751733AbWBQUcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWBQUcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWBQUcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:32:11 -0500
Received: from mail20.messagelabs.com ([216.82.245.67]:54947 "HELO
	mail20.messagelabs.com") by vger.kernel.org with SMTP
	id S1751733AbWBQUcK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:32:10 -0500
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-11.tower-20.messagelabs.com!1140208323!29341084!1
X-StarScan-Version: 5.5.9.1; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] SIIG 8-port serial boards support
Date: Fri, 17 Feb 2006 14:32:03 -0600
Message-ID: <335DD0B75189FB428E5C32680089FB9F8034C6@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCH] SIIG 8-port serial boards support
Thread-Index: AcY0ATX2STGavwkiRqC/f0+IpkZyEg==
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <linux-kernel@vger.kernel.org>
Cc: <rmk+lkml@arm.linux.org.uk>
X-OriginalArrivalTime: 17 Feb 2006 20:32:03.0628 (UTC) FILETIME=[363DF6C0:01C63401]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
(Sorry for the ugly copy/paste here, grabbing from a web browser to
email)

On Fri, Feb 17, 2006 at 08:02:13PM +0000, Russell King wrote:
> Finally, let me explain why I favour the termios solution.  The
biggest
> (and most important) aspect is that it allows existing applications
> such as minicom and gettys to work as expected - getting the correct
> handshaking mode that they desire without having to change userspace.

What about creating a "struct termiox".
Yeah, it creates a new ioctl, but it is a pretty standard
ioctl among Unix's.

I know adding termiox calls has been brought up before in
the past, and of course, nothing ever gets added...

Scott



