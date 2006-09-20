Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWITVul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWITVul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWITVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:50:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbWITVuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:50:39 -0400
Date: Wed, 20 Sep 2006 14:50:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Dave Jones" <davej@redhat.com>,
       "Marek Vasut" <marek.vasut@gmail.com>
Subject: Re: 2.6.19 -mm merge plans (input patches)
Message-Id: <20060920145006.05117085.akpm@osdl.org>
In-Reply-To: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com>
References: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 17:29:43 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > remove-silly-messages-from-input-layer.patch
> 
> I firmly believe that we should keep reporting these conditions. This
> way we can explain why keyboard might be losing keypresses. I am open
> to changing the message text. Would "atkbd.c: keyboard reported error
> condition (FYI only)" be better? It is KERN_DEBUG after all.

But it irritates some people.

Perhaps we could make the message disable itself after the first 5-10
instances?

> > input-i8042-disable-keyboard-port-when-panicking-and-blinking.patch
> > i8042-activate-panic-blink-only-in-x.patch
> 
> There was a concern that blinking is useful even when not running X.
> Do you have any input?

No, sorry.

