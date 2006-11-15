Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161738AbWKOV5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161738AbWKOV5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161778AbWKOV5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:57:49 -0500
Received: from mailer1.psc.edu ([128.182.58.100]:5077 "EHLO mailer1.psc.edu")
	by vger.kernel.org with ESMTP id S1161738AbWKOV5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:57:49 -0500
Message-ID: <455B8D56.1070308@psc.edu>
Date: Wed, 15 Nov 2006 16:57:42 -0500
From: John Heffner <jheffner@psc.edu>
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
MIME-Version: 1.0
To: eli@dev.mellanox.co.il
CC: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: UDP packets loss
References: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il> <20061114143531.2ee7eae0@freekitty> <455A4DED.8090107@intel.com>
In-Reply-To: <455A4DED.8090107@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> Having it bounce between cpu's would likely result in a lower 
> performance anyway: you really want it bound to a single CPU to benefit 
> from cache hits on the various involved data structs that are needed to 
> receive the data from hardware, do accounting etc.

Additionally: beware you will likely get a fair amount of packet 
reordering as well.

   -John
