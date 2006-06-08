Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWFHVRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWFHVRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWFHVRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:17:14 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:48299
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965019AbWFHVRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:17:12 -0400
Message-ID: <448893DD.7010207@microgate.com>
Date: Thu, 08 Jun 2006 16:17:17 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
References: <200606081412_MC3-1-C1EF-69A3@compuserve.com>
In-Reply-To: <200606081412_MC3-1-C1EF-69A3@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> Very infrequently I get kernel freezes while pppd is exiting.
> Today I finally got traces from the serial console.

Chuck:

What kind of device are you using with pppd?
(so I can identify which driver is feeding
the tty layer receive data)

Are you setting the low_latency flag on that device?
(setserial)

Thanks,
Paul
