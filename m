Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWBPTPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWBPTPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWBPTPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:15:55 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:48111 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S932351AbWBPTPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:15:54 -0500
Date: Thu, 16 Feb 2006 11:15:49 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
To: Ulrich Drepper <drepper@gmail.com>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FUTEX: one more return .
In-Reply-To: <a36005b50602161011v237a4e22x436716103c7c6b88@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602161115420.30911@dhcp153.mvista.com>
References: <200602161742.k1GHgs2m029392@dhcp153.mvista.com>
 <a36005b50602161011v237a4e22x436716103c7c6b88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok ..


On Thu, 16 Feb 2006, Ulrich Drepper wrote:

> On 2/16/06, Daniel Walker <dwalker@mvista.com> wrote:
>> Continue the theme of returns .
>
> No, that's wrong.  I got Ingo to remove this code and he documented it:
>
> =====
> - race fix: do not bail out in the list walk when the list_op_pending
>   pointer cannot be followed by the kernel - another userspace thread
>   may have already destroyed the mutex (and unmapped it), before this
>   thread had a chance to clear the field.
> =====
>
