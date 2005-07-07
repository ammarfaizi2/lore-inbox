Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVGGVX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVGGVX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVGGVVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:21:50 -0400
Received: from mail.riseup.net ([69.90.134.155]:31968 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S261437AbVGGVTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:19:46 -0400
Date: Thu, 7 Jul 2005 23:22:38 +0200
From: st3@riseup.net
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Dave Jones <davej@redhat.com>, cpufreq@lists.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: enhanced intel speedstep feature was Re: speedstep-centrino on
 dothan
Message-ID: <20050707232238.077c7c1c@horst.morte.male>
In-Reply-To: <20050707211033.GB24774@isilmar.linta.de>
References: <20050706112202.33d63d4d@horst.morte.male>
	<42CC37FD.5040708@tmr.com>
	<20050706211159.GF27630@redhat.com>
	<20050706235557.0c122d33@horst.morte.male>
	<20050707220027.413343d4@horst.morte.male>
	<20050707200648.GA29142@redhat.com>
	<20050707222225.5b3113e0@horst.morte.male>
	<20050707211033.GB24774@isilmar.linta.de>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005 23:10:33 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Do you use ACPI-based idling? If so, in which state is the CPU in (cat
> /proc/acpi/processor/*/power ? I suspect that you do not use ACPI (else 
> you wouldn't need the table-based approach) or that the ACPI-based idling is
> broken on your notebook; as then the Linux idle handler  only makes use of 
> "hlt" (IIRC), that is ACPI C1, while throttling "forces" ACPI C2 (again
>  IIRC).

For idling, I didn't mean 'real idling', but instead just 'doing nothing'
in ACPI C1 state, that's simply a CPU usage < 1%.

Sorry for being so lame =)


--
ciao
st3

