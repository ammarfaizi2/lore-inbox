Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161472AbWJKVRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161472AbWJKVRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161484AbWJKVRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:17:40 -0400
Received: from kurby.webscope.com ([204.141.84.54]:58786 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1161453AbWJKVR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:17:27 -0400
Message-ID: <452D5EF7.80303@linuxtv.org>
Date: Wed, 11 Oct 2006 17:15:35 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [patch 06/67] Video: cx24123: fix PLL divisor setup
References: <20061011204756.642936754@quad.kroah.org> <20061011210353.GG16627@kroah.com>
In-Reply-To: <20061011210353.GG16627@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Yeasah Pell <yeasah@schwide.net>
> 
> The cx24109 datasheet says: "NOTE: if A=0, then N=N+1"
> 
> The current code is the result of a misinterpretation of the datasheet to
> mean exactly the opposite of the requirement -- The actual value of N is 1
> greater than the value written when A is 0, so 1 needs to be *subtracted*
> from it to compensate.
> 
> Signed-off-by: Yeasah Pell <yeasah@schwide.net>
> Signed-off-by: Steven Toth <stoth@hauppauge.com>
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Greg,

When you apply this patch to your 2.6.18.y tree (and also to your
2.6.17.y tree) , can you please preceed the patch title with 'DVB'
instead of 'VIDEO' ?

I'll be sure to specify the subsystem, instead of only the driver name
in future patches.

Thanks,

Michael Krufky

