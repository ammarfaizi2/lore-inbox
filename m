Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWHVR1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWHVR1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWHVR1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:27:19 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:31990 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S932297AbWHVR1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:27:18 -0400
Date: Tue, 22 Aug 2006 19:23:39 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: [PATCH] Update Documentation/devices.txt
Message-ID: <20060822172339.GA15581@aepfle.de>
References: <87d5aserky.fsf@slug.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d5aserky.fsf@slug.be.48ers.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, Peter Korsgaard wrote:


> -229 char	IBM iSeries virtual console
> -		  0 = /dev/iseries/vtty0	First console port
> -		  1 = /dev/iseries/vtty1	Second console port
> +229 char	IBM iSeries/pSeries virtual console
> +		  0 = /dev/hvc0			First console port

hvc0 is pSeries only, iSeries uses tty1 for its OS400 provided telnet
console. I doubt there is a hvc1.
