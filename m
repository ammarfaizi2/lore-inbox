Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWITVzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWITVzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWITVzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:55:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3253 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932221AbWITVzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:55:23 -0400
Date: Wed, 20 Sep 2006 17:55:07 -0400
From: Dave Jones <davej@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Marek Vasut <marek.vasut@gmail.com>
Subject: Re: 2.6.19 -mm merge plans (input patches)
Message-ID: <20060920215507.GM1153@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Marek Vasut <marek.vasut@gmail.com>
References: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609201429m753de40fo194d48427402c6cd@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 05:29:43PM -0400, Dmitry Torokhov wrote:
 > On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
 > >
 > > remove-silly-messages-from-input-layer.patch
 > 
 > I firmly believe that we should keep reporting these conditions. This
 > way we can explain why keyboard might be losing keypresses. I am open
 > to changing the message text. Would "atkbd.c: keyboard reported error
 > condition (FYI only)" be better?
 
Q: What do you expect users to do when they see the message?

 > It is KERN_DEBUG after all.

users can, and do read dmesg.

	Dave

