Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270658AbUJUFKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270658AbUJUFKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270629AbUJUFJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:09:55 -0400
Received: from [12.177.129.25] ([12.177.129.25]:15556 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S270655AbUJUFJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:09:29 -0400
Message-Id: <200410210618.i9L6IC9O006743@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Martin Waitz <tali@admingilde.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: generic hardirq handling for uml 
In-Reply-To: Your message of "Wed, 20 Oct 2004 02:11:24 +0200."
             <20041020001124.GA29215@admingilde.org> 
References: <20041020001124.GA29215@admingilde.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Oct 2004 02:18:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tali@admingilde.org said:
> I just ported arch/um to generic hardirq handling. It works for me on
> a 2.6.9-rc4-mm1 kernel. 

Thanks.  I already had most of this in my tree, but you caught a few things
I missed, especially the #include cleanup.  However, the removal of config.h
was a bit much since there are still references to CONFIG_SMP.

				Jeff

