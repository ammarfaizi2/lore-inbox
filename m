Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbVKENsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbVKENsP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 08:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVKENsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 08:48:15 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:53669 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750869AbVKENsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 08:48:14 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Edgar Hucek <hostmaster@ed-soft.at>
Subject: Re: New Linux Development Model
Date: Sat, 5 Nov 2005 13:47:54 +0000
User-Agent: KMail/1.8.92
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
References: <436C7E77.3080601@ed-soft.at> <20051105122958.7a2cd8c6.khali@linux-fr.org> <436CB162.5070100@ed-soft.at>
In-Reply-To: <436CB162.5070100@ed-soft.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511051347.54833.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 November 2005 13:19, Edgar Hucek wrote:
> Hi.
>
> Sorry for not posting my Name.
>
> Maybe you don't understand what i wanted to say or it's my bad english.
> The ipw2200 driver was only an example. I had also problems with, vmware,
> unionfs...

Read the document linked to by Jean. It explains why a volatile API is 
ultimately beneficial to the Linux development process.

It's frustrating for vendors and maintainers to keep their code up to date 
with the latest kernel, but if it's done incrementally after Linus releases 
(or during the very lengthy RC process), it's usually very easy.

Also, you're gelling together many projects which have completely different 
reasons for breaking across kernel revisions.

ipw2200 "works" in 2.6.14, it's just the maintainer has opted to use a "stable 
version" which lacks experimental features while ieee80211 gets up to 
scratch.

OTOH, unionfs is poorly maintained and is a particularly sore example of how 
the linux development model is detrimental to external module development.

There are people constantly working to make binary modules like VMWare, NVIDIA 
and ATI work under the newest kernels. Just google it. Ultimately we can't 
allow ourselves to be held down by slow-moving binary vendors. It's too 
inefficient (not to mention of questionable ethics).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
