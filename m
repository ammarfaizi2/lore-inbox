Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSKUWf1>; Thu, 21 Nov 2002 17:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSKUWf1>; Thu, 21 Nov 2002 17:35:27 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:19607 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265097AbSKUWf0>;
	Thu, 21 Nov 2002 17:35:26 -0500
Date: Thu, 21 Nov 2002 22:40:35 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unsupported AGP-bridge on VIA VT8633
Message-ID: <20021121224035.GA28094@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Stian Jordet <liste@jordet.nu>, linux-kernel@vger.kernel.org
References: <1037916067.813.7.camel@chevrolet.hybel> <20021121221134.GA25741@suse.de> <1037917231.3ddd5c2f5d98a@webmail.jordet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037917231.3ddd5c2f5d98a@webmail.jordet.nu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 11:20:31PM +0100, Stian Jordet wrote:

 > You were not really clear here. I tried it as a boot-time argument, because I
 > have agp-support compiled in. But I guess I could and should try it as a module.

Yup. Then do a `modprobe agpgart agp_try_unsupported=1'

 > I'll do that now. But why do I have to use agp_try_unsupported=1?

Because if it works, we can then add it to the ID table.

	Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
