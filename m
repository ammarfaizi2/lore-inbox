Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280005AbRKIRWo>; Fri, 9 Nov 2001 12:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280006AbRKIRWZ>; Fri, 9 Nov 2001 12:22:25 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:33784 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S280005AbRKIRWP>; Fri, 9 Nov 2001 12:22:15 -0500
Message-ID: <3BEC109C.1EEDBA71@mvista.com>
Date: Fri, 09 Nov 2001 09:21:32 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, Jonas Diemer <diemer@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: VIA 686 timer bugfix incomplete
In-Reply-To: <E161ydI-000178-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------96F33AAE31F6E567844CB6EB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------96F33AAE31F6E567844CB6EB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> 
> > Me thinks the real solution is the ACPI pm timer.  3 times the
> > resolution of the PIT and you can not stop it.  The high-res-timers
> > patch will allow you to use this as the time keeper and just use the PIT
> > to generate interrupts.
> 
> For awkward boxes you can use the PIT, for good boxes we can use rdtsc or
> eventually the ACPI timers when running with ACPI

I am attempting to use the ACPI timer without waiting for or running
ACPI.  After all it is there if you can find it.

George
--------------96F33AAE31F6E567844CB6EB
Content-Type: text/x-vcard; charset=us-ascii;
 name="george.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for george anzinger
Content-Disposition: attachment;
 filename="george.vcf"

begin:vcard 
n:Anzinger;George
x-mozilla-html:FALSE
org:MontaVista Software
adr:;;;;;;
version:2.1
email;internet:george@mvista.com
note;quoted-printable: http://sourceforge.net/projects/high-res-timers=0D=0A http://sourceforge.net/projects/rtsched/  
x-mozilla-cpt:;16704
fn:George Anzinger
end:vcard

--------------96F33AAE31F6E567844CB6EB--

