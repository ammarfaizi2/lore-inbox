Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUDHWh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUDHWh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:37:27 -0400
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:18722
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S262730AbUDHWhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:37:25 -0400
Subject: Re: Does OSS sound work in 2.6 or not?
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4075BDE0.6050302@tmr.com>
References: <4075BDE0.6050302@tmr.com>
Content-Type: text/plain
Message-Id: <1081463836.3223.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 08 Apr 2004 18:37:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 17:02, Bill Davidsen wrote:
> I have several user machines I would like to convert to 2.6 because they 
> run threaded applications and would be happier if I did. However, being 
> able to play forwarded wav files is also needed. I have been assurred by 
> several people in Email that it does, *without* converting the whole 
> machine from OSS to ALSA, but by running the ALSA+OSS emulation.

Can you clarify the question?  What do you mean by "*without* converting
the whole machine from OSS to ALSA"?  Do you mean you willing to convert
to the ALSA drivers but want to continue to use OSS applications?  Or do
you mean you don't want to convert to ALSA at all?  You obviously can't
use ALSA+OSS emulation if your not willing to convert to the ALSA
drivers since basically OSS emulation is just a few ALSA modules you
load *in addition* to the ALSA hardware drivers that allow ALSA to
provide an OSS emulation layer to OSS only applications.

Of course, OSS drivers are still available in 2.6, even though they are
deprecated.  You can just continue to use these just like you always
have in 2.4, no ALSA at all.

Later,
Tom

 
 

