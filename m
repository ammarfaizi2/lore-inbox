Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263571AbVBCTEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbVBCTEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbVBCTEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:04:42 -0500
Received: from [195.23.16.24] ([195.23.16.24]:14979 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S263014AbVBCTES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:04:18 -0500
Message-ID: <42027594.9090402@grupopie.com>
Date: Thu, 03 Feb 2005 19:03:48 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Godin <Ian.Godin@lowrydigital.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drive performance bottleneck
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com> <42026207.4090007@vgertech.com> <ef0635f8b4257d18fad10882a2c79f64@lowrydigital.com>
In-Reply-To: <ef0635f8b4257d18fad10882a2c79f64@lowrydigital.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Godin wrote:
> [...]
>   Definitely have been able to repeat that here, so the SG driver 
> definitely appears to be broken.  At least I'm glad I am not going 
> insane, I was starting to wonder :)
> 
>   I'll run some more tests with O_DIRECT and such things, see if I can 
> figure out what the REAL max speed is.

FYI there was a patch running around last April that made a new option 
for "dd" to make it use O_DIRECT. You can get it here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108135935629589&w=2

Unfortunately this hasn't made it into coreutils. IIRC there were issues 
about dd being multi-platform and the way O_DIRECT was done in other 
systems.

Anyway, you can patch dd yourself and have a tool for debugging with 
O_DIRECT. I hope this helps,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
