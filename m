Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVJ1CaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVJ1CaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 22:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVJ1CaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 22:30:13 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:53970 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S965053AbVJ1CaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 22:30:11 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Re: The "best" value of HZ
Date: Fri, 28 Oct 2005 03:31:21 +0100
User-Agent: KMail/1.8.92
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <200510280118.42731.cloud.of.andor@gmail.com>
In-Reply-To: <200510280118.42731.cloud.of.andor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510280331.21112.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 00:18, Claudio Scordino wrote:
> Hi,
>
>     during the last years there has been a lot of discussion about the
> "best" value of HZ... On i386 was 100, then became 1000, and finally was
> set to 250. I'm thinking to do an evaluation of this parameter using
> different architectures.
>
> Has anybody thought to give the possibility to modify the value of HZ at
> boot time instead of at compile time ? This would allow to easily test
> different values on different machines and create a table containing the
> "best" value for each architecture...  At this moment, instead, we have to
> recompile the kernel for each different value :(
>
> Do you think there would be much work to do that ?
> Do you think it would be a desired feature the knowledge of the best value
> for each architecture with more precision ?

Google for "dynticks". There's obviously an overhead associated with HZ not 
being a constant (the compiler cannot optimise many expressions), but the 
feature is being worked on nonetheless.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
