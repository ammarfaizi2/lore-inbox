Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVAHWxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVAHWxa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVAHWx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:53:29 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:9627 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261234AbVAHWwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:52:00 -0500
Message-ID: <41E0640C.1030500@f2s.com>
Date: Sat, 08 Jan 2005 22:51:56 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Zabolotny <zap@homelink.ru>,
       Vincent Sanders <vince@simtec.co.uk>
Subject: Re: [PATCH 1/5] WM97xx touch driver AC97 plugin
References: <1105106557.9143.1001.camel@cearnarfon> <1105223060.24592.133.camel@krustophenia.net>
In-Reply-To: <1105223060.24592.133.camel@krustophenia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> Why an OSS driver and not ALSA?  OSS is deprecated.

 From my POV, because I havent got time to port it to ALSA yet ;-)

from another POV, because ALSA is broken on ARM (or was), and other 
platforms, wrt the mmap() operation mode. this makes it a bit pointless 
to port a driver to thats mainly used for arm based PDAs...
