Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTLUMiA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 07:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTLUMh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 07:37:59 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:43420 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S262767AbTLUMh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 07:37:58 -0500
From: Duncan Sands <baldrick@free.fr>
To: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0-test11 BK: sg and scanner modules not auto-loaded?
Date: Sun, 21 Dec 2003 13:37:30 +0100
User-Agent: KMail/1.5.4
References: <20031219181039.GI3017@kroah.com> <20031221003020.63E6A2C0B8@lists.samba.org> <20031221012531.GB30123@merlin.emma.line.org>
In-Reply-To: <20031221012531.GB30123@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312211337.30900.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 December 2003 02:25, Matthias Andree wrote:
> On Sat, 20 Dec 2003, Rusty Russell wrote:
> > It's been argued that kmod should place a request with the hotplug
> > subsystem, rather than call modprobe, but that's a little too radical
> > for me just yet.
>
> Hotplug works for 2.4, I don't know what is different in 2.6 - are there
> hotplug relevant kernel changes? Stupid question maybe, but I'm asking
> nonetheless :-)

I haven't been following this thread, so I don't know if this is relevant:
do you have the *very latest* hotplug scripts?  The previous ones tested
the kernel version against "2.5", while the latest test against that and also
"2.6".  I think this was in the usb script.  Without the "2.6" test device
scripts are not run, at least for usb devices.

Ciao,

Duncan.
