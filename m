Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbTGOIcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbTGOIcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:32:22 -0400
Received: from c213-100-44-190.swipnet.se ([213.100.44.190]:48914 "EHLO
	joelm.2y.net") by vger.kernel.org with ESMTP id S266897AbTGOIcR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:32:17 -0400
Subject: Re: Inspiron 8000 makes high pitch noise only with 2.6.0-test1
From: Joel Metelius <joel.metelius@home.se>
To: Daniel.Dorau@alumni.TU-Berlin.DE
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4299.194.175.125.228.1058254785.squirrel@mailbox.TU-Berlin.DE>
References: <4299.194.175.125.228.1058254785.squirrel@mailbox.TU-Berlin.DE>
Content-Type: text/plain
Message-Id: <1058258721.2423.2.camel@joelm.2y.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jul 2003 10:45:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try turning off 

CONFIG_APM_CPU_IDLE

it help me and others, but it had nothing to do with ethernet drivers...

/joel

On Tue, 2003-07-15 at 09:39, Daniel.Dorau@alumni.TU-Berlin.DE wrote:
> Hi there,
> yesterday I tried the 2.6.0-test1 kernel for the first time.
> Installation went flawlessly. However I noticed a high pitch
> noise from my notebook everytime after the ethernet driver
> was loaded, no matter which one (eepro100 or e100).
> It is exactly the noise that my notebook only did with 2.4
> when _actually_ transmitting data on IRDA.
> I have no clue whatsoever how the same noise is being triggered
> by the 2.6 kernel. Disabling IRDA (kernel+BIOS) didn't help.
> Since that noise is somewhat nerving, I would be very happy
> if someone has an idea how to fix that.
> This noise does definitely not appear on 2.4 kernel except when
> IRDA is active. On 2.6 I can hear it all the time one the
> ethernet driver is loaded. It is only interrupted by heavy disc
> activity.
> Does anybody has an idea?
> 
> Please CC me on reply.
> 
> Thank you
> Daniel
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

