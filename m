Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271854AbTGYAwI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271855AbTGYAwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:52:08 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:35088 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S271854AbTGYAwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:52:01 -0400
Date: Fri, 25 Jul 2003 11:06:59 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: in-kernel crypto
In-Reply-To: <20030724225919.GE12002@werewolf.able.es>
Message-ID: <Mutt.LNX.4.44.0307251105500.14288-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, J.A. Magallon wrote:

> Hi all...
> 
> Just a couple questions about the crypto routines present in kernel:
> 
> - Are they just for in-kernel use, some like encrypted filesystems, or can
>   it be used from userspace ?

It's just for the kernel at the moment.

> - It it is usable from userland, has it any advantage over doing it in
>   userspace ? IE, for example, can ssh be faster it used the kernel crypto ?

No real point until there is hardware support, then userspace can take 
advantage of it.


> - If so, how ? Special library ? syscalls ?

Probably a filesystem.


- James
-- 
James Morris
<jmorris@intercode.com.au>

