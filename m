Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLNQzl>; Thu, 14 Dec 2000 11:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLNQza>; Thu, 14 Dec 2000 11:55:30 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:25348 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129345AbQLNQzS>; Thu, 14 Dec 2000 11:55:18 -0500
Message-Id: <200012141624.eBEGOls50132@aslan.scsiguy.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Thu, 14 Dec 2000 16:48:41 +0100."
             <200012141548.QAA22537@ns.caldera.de> 
Date: Thu, 14 Dec 2000 09:24:47 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In article <200012132215.eBDMFas35908@aslan.scsiguy.com> you wrote:
>> For those
>> of you building the driver as a module, take note that the module
>> name is now "aic7xxx_mod" rather than "aic7xxx".
>
>Could you please undo that change?
>Postfixing a module name with _mod does not make sense.
>Yes, some modules use it - but that's just because they have older source
>files that are called like the multi-object module.

It will change today assuming I can get the build to work consistently.
The change occurred because the driver now is composed of multiple
objects.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
