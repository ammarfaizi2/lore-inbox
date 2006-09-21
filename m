Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWIUBSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWIUBSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 21:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWIUBSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 21:18:30 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:52327 "EHLO
	asav14.insightbb.com") by vger.kernel.org with ESMTP
	id S1750916AbWIUBS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 21:18:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAEKEEUWBToobLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.19 -mm merge plans (input patches)
Date: Wed, 20 Sep 2006 21:18:27 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Marek Vasut <marek.vasut@gmail.com>
References: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com> <20060920215507.GM1153@redhat.com>
In-Reply-To: <20060920215507.GM1153@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202118.27741.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 17:55, Dave Jones wrote:
> On Wed, Sep 20, 2006 at 05:29:43PM -0400, Dmitry Torokhov wrote:
>  > On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
>  > >
>  > > remove-silly-messages-from-input-layer.patch
>  > 
>  > I firmly believe that we should keep reporting these conditions. This
>  > way we can explain why keyboard might be losing keypresses. I am open
>  > to changing the message text. Would "atkbd.c: keyboard reported error
>  > condition (FYI only)" be better?
>  
> Q: What do you expect users to do when they see the message?
>

A: Nothing. But when they tell me that sometimes they lose keystrokes I
can ask them if they see it in dmesg. And if they see it there is nothing
I can do. Again, if you could suggest a better wording that would not alarm
unsuspecting users that would be great.

-- 
Dmitry
