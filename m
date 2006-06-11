Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWFKEgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWFKEgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 00:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWFKEge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 00:36:34 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:6733 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161077AbWFKEge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 00:36:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=IOUDjGUuFfmVE8k1coeXH1GKLWZei2SXjb4980o6CDl7xt/Bnn/Wp5k45f7a2bTWn+w/657Qd/BmhEhzoZiYfF2nbtyYZK3UpCf7M2ZvQd5evaP58aRePuqvPIVNrET7Ja5PWZ4sVDYCioqcrMTHF3ff1VE5uyhvS3m5R/4+c7g=
Message-ID: <448B9DC6.8030109@gmail.com>
Date: Sun, 11 Jun 2006 12:36:22 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
References: <44893407.4020507@gmail.com> <448AC8BE.7090202@gmail.com>	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>	 <448B38F8.2000402@gmail.com>	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>	 <448B61F9.4060507@gmail.com>	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>	 <448B6ED3.5060408@gmail.com>	 <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>	 <448B8818.1010303@gmail.com> <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
In-Reply-To: <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> My point is: 'Multiple active drivers feature' is a natural consequence
>> of the evolution of the code, but the only way to take advantage of it
>> is if we provide a means for the user to use it.  And we are not
>> providing the means.
> 
> I'd rather not provide the means and defer this capability to a user
> space implementation where we can achieve true multi-user,
> multi-adapter and multi-head support. The more features we add to the
> VT layer today, the harder it will be to replace it in the future.

No, I'm not adding any new features.  We have bind capability, the only
added feature is unbind, that's it.

> 
> I'd like to keep the sysfs attributes as simple as possible because if
> they get too complex and flexible no one is going to know how to set
> them. But you're writing the code and you'll do what you think is
> best.

I'm just trying to evolve the code, with the least amount or no breakage.
There's nothing revolutionary here.

Tony
 

