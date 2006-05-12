Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWELTDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWELTDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWELTDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:03:22 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:45779 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751335AbWELTDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:03:21 -0400
Message-ID: <44649A2E.4070803@tmr.com>
Date: Fri, 12 May 2006 10:22:38 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060409 SeaMonkey/1.0.1
MIME-Version: 1.0
To: marekw1977@yahoo.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: acpi4asus
References: <20060511130743.GG15876@mail.muni.cz> <20060511073211.1da40329.akpm@osdl.org> <200605121116.11930.marekw1977@yahoo.com.au>
In-Reply-To: <200605121116.11930.marekw1977@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek W wrote:

> I am far from qualified to comment on this, but from a users point of view, is 
> it possible to not have laptop specific code in the kernel?
> I have had two Linux laptops and with both I had ACPI issues.
> The vendors of both laptops (Toshiba Tecra S1 and now an Asus W3V) don't seem 
> to be following standards. With both I seem to need to patch ACPI to get 
> various functions of the laptop to work.
> I would love to see laptop specific functionality definitions exist outside 
> the kernel.
> 
I don't think that forcing laptop users to have their own code outside 
the kernel is really the best approach for either the developers or the 
users. Most users will not have the expertise or time to develop 
patches, so teaching the kernel to handle special cases is likely to 
benefit more users and avoid reinventing the wheel.

Having to maintain and out-of-mainline kernel tree is a time-consuming 
job, and even if you can do it you may delay upgrades or build a kernel 
without the added features if they are not required for normal operation.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

