Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVGGUXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVGGUXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVGGUVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:21:34 -0400
Received: from buffy.riseup.net ([69.90.134.155]:18049 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S261352AbVGGUTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:19:33 -0400
Date: Thu, 7 Jul 2005 22:22:25 +0200
From: st3@riseup.net
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: enhanced intel speedstep feature was Re: speedstep-centrino on
 dothan
Message-ID: <20050707222225.5b3113e0@horst.morte.male>
In-Reply-To: <20050707200648.GA29142@redhat.com>
References: <20050706112202.33d63d4d@horst.morte.male>
	<42CC37FD.5040708@tmr.com>
	<20050706211159.GF27630@redhat.com>
	<20050706235557.0c122d33@horst.morte.male>
	<20050707220027.413343d4@horst.morte.male>
	<20050707200648.GA29142@redhat.com>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005 16:06:48 -0400
Dave Jones <davej@redhat.com> wrote:

> On Thu, Jul 07, 2005 at 10:00:27PM +0200, st3@riseup.net wrote:
>   > Enabling, say, a duty cycle of 12.5% means that the CPU chip will be driven
>  > by clock just one time every eight, thus reducing power consumption and
>  > temperature (and it speeds down dramatically the CPU, too =).
>  > 
>  > I tested it so far on my Pentium M Dothan 715 and on a Dothan 725.
>  > 
>  > What do you think, could this be useful? I could provide a patch or a
>  > stand-alone module. Should I write an interface to sysfs?
> 
> You just reinvented the p4-clockmod driver :-)

Oops. =)

> This hasn't been seen to save any power whatsoever that I've seen.

It drops down power rating by 1500-1800mW on my Toshiba Satellite A50
while idling at 400MHz.

> I've heard a few reports that it reduces heat for a few folks, but
> betting on it increasing your battery life is probably a push.

Just a latest question: can be p4-clockmod used together with
speedstep-centrino? If not, would it make any sense to patch
speedstep-centrino to use this feature too?


--
ciao
st3

