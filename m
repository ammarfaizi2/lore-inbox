Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUCBNLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 08:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUCBNLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 08:11:18 -0500
Received: from [195.23.16.24] ([195.23.16.24]:2526 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261634AbUCBNLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 08:11:16 -0500
Message-ID: <40448799.5030508@grupopie.com>
Date: Tue, 02 Mar 2004 13:09:45 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>,
       Daniel Robbins <drobbins@gentoo.org>, linux-kernel@vger.kernel.org,
       Mike@kordik.net, kpfleming@backtobasicsmgmt.com
Subject: Re: [PATCH] Re: 2.6.3-bk9 QA testing: firewire good, USB printing dead
References: <1077933682.14653.23.camel@wave.gentoo.org> <20040228021040.GA14836@kroah.com> <20040229095139.GH3149@suse.de> <20040301074348.GA7646@ip68-4-255-84.oc.oc.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:

>  
> +		/* We must increment writecount here, and not at the
> +		 * end of the loop. Otherwise, the final loop iteration may
> +		 * be skipped, leading to incomplete printer output.
> +		 */


You are correct.


I'm affraid this is my fault, for correcting a bug and letting another one take 
its place :(

It seems that this patch squashes them both. It should go in ASAP.

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

