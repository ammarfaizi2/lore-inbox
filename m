Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271082AbTGPUIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271117AbTGPUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:07:23 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:25086 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S271082AbTGPUFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:05:43 -0400
Subject: Re: [PATCH] O6int for interactivity
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058386833.2276.262.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Jul 2003 16:20:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

I use the infinitely superior (to XMMS), interactive testing tool
mplayer! :-)

My test consists of playing a video in mplayer with software scaling,
(ie. no xv) and refreshing various fat web pages. This as you are fully
aware would cause mozilla to gobble up CPU in short bursts of
approximately .5 - 3 seconds during which time the video would be very
choppy.

06int is much improved in this scenario, the pauses during refreshing
web pages have almost disappeared. There are still very small hiccups in
the video playback during the refreshes.

Also, I use a local web page that queries a local mysql db to display a
large table in mozilla. So, mozilla, apache and mysql are all local.
06int is a huge improvement in this area as well. It is decreases the
choppiness of the video greatly. Previously this would cause almost a
complete halt of the video for several seconds and now I would say there
is only a small amount choppiness. It is still pretty choppy on the
initial load of that page after a reboot, maybe nothing is cached yet?

Thanks for your hard work!

Regards,

Shane




