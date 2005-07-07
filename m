Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVGGUMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVGGUMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVGGUMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:12:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63185 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262349AbVGGUHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:07:01 -0400
Date: Thu, 7 Jul 2005 16:06:48 -0400
From: Dave Jones <davej@redhat.com>
To: st3@riseup.net
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: enhanced intel speedstep feature was Re: speedstep-centrino on dothan
Message-ID: <20050707200648.GA29142@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, st3@riseup.net,
	linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <20050706112202.33d63d4d@horst.morte.male> <42CC37FD.5040708@tmr.com> <20050706211159.GF27630@redhat.com> <20050706235557.0c122d33@horst.morte.male> <20050707220027.413343d4@horst.morte.male>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050707220027.413343d4@horst.morte.male>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 10:00:27PM +0200, st3@riseup.net wrote:
  > Enabling, say, a duty cycle of 12.5% means that the CPU chip will be driven
 > by clock just one time every eight, thus reducing power consumption and
 > temperature (and it speeds down dramatically the CPU, too =).
 > 
 > I tested it so far on my Pentium M Dothan 715 and on a Dothan 725.
 > 
 > What do you think, could this be useful? I could provide a patch or a
 > stand-alone module. Should I write an interface to sysfs?

You just reinvented the p4-clockmod driver :-)
This hasn't been seen to save any power whatsoever that I've seen.
I've heard a few reports that it reduces heat for a few folks, but
betting on it increasing your battery life is probably a push.

		Dave

