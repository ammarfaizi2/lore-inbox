Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275078AbRJANuU>; Mon, 1 Oct 2001 09:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275086AbRJANuL>; Mon, 1 Oct 2001 09:50:11 -0400
Received: from pscgate.progress.com ([192.77.186.1]:12989 "EHLO
	pscgate.progress.com") by vger.kernel.org with ESMTP
	id <S275078AbRJANtw>; Mon, 1 Oct 2001 09:49:52 -0400
Subject: Re: Broken APIC detection 2.4.10?
From: "Sujal Shah" <sshah@progress.com>
Reply-To: sujal@sujal.net
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109301126.NAA24615@harpo.it.uu.se>
In-Reply-To: <200109301126.NAA24615@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.27.08.08 (Preview Release)
Date: 01 Oct 2001 09:48:33 -0400
Message-Id: <1001944127.32358.3.camel@pcsshah>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-30 at 07:26, Mikael Pettersson wrote:
> On 27 Sep 2001 18:21:54 -0400, Sujal Shah wrote:
[SNIP]
> Please elaborate: What does "This" in "This was not the case before."
> refer to? The "Could not enable APIC!" boot message or the XT-PIC in
> /proc/interrupts?
> 

I'm just dumb.  The message was new, but the behavior (non-APIC
interrupts) was not.  I'm truly sorry for any confusion.

I was trying to track down another problem (the PNPBios issue that looks
to have been patched and an ALSA driver issue) when I just saw the
message, which I had never seen before.

Sorry.

Sujal

> 2.4.10 merged code from 2.4-ac which (in some .configs) will attempt
> to enable the CPU's local APIC. The boot message above is printed if
> your CPU doesn't have one.
> 
> >Anyone have any ideas why this is?  The APIC stuff was getting detected
> >fine in 2.4.7.
> 
> Can you send me your .configs and boot logs for both 2.4.7 and 2.4.10?
> I don't think there is an actual problem, but I'd like to make sure.
> 
> /Mikael
-- 
---- Sujal Shah --- sujal@sujal.net ---

        http://www.sujal.net

Now Playing: none

