Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWHaKVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWHaKVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWHaKVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:21:10 -0400
Received: from sperry-01.control.lth.se ([130.235.83.188]:60632 "EHLO
	sperry-01.control.lth.se") by vger.kernel.org with ESMTP
	id S1750838AbWHaKVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:21:09 -0400
Message-ID: <44F6B80D.2020409@control.lth.se>
Date: Thu, 31 Aug 2006 12:21:01 +0200
From: Martin Ohlin <martin.ohlin@control.lth.se>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se> <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
In-Reply-To: <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

> The CKRM e-series is a PID based CPU Controller. It did a good job of
> controlling and smoothing out the load (and variations) and even
> worked with groups. But it achieved all this through some amount of
> complexity.

I have now downloaded and looked at the code you refer to. But as far as 
I can see, the PID controller is only used for load balancing between 
CPUs, not for controlling the bandwidth/time of individual tasks. Is 
this correct or did I miss something?

/Martin
