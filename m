Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751944AbWCAXhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbWCAXhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 18:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWCAXhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 18:37:11 -0500
Received: from mail.dvmed.net ([216.237.124.58]:37264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751944AbWCAXhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 18:37:09 -0500
Message-ID: <44063023.9010603@pobox.com>
Date: Wed, 01 Mar 2006 18:37:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux@dominikbrodowski.net, Netdev List <netdev@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: avoid binding hostap_cs to Orinoco cards
References: <200603012259.k21MxEN3013604@hera.kernel.org>
In-Reply-To: <200603012259.k21MxEN3013604@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> commit 40e3cad61197fce63853e778db020f7637d988f2
> tree 6e086c930e1aef0bb24eb61af42d1f3c1fb7d38c
> parent f0892b89e3c19c7d805825ca12511d26dcdf6415
> author Pavel Roskin <proski@gnu.org> Tue, 28 Feb 2006 11:18:31 -0500
> committer Dominik Brodowski <linux@dominikbrodowski.net> Wed, 01 Mar 2006 11:12:00 +0100
> 
> [PATCH] pcmcia: avoid binding hostap_cs to Orinoco cards
> 
> Don't just use cards with PCMCIA ID 0x0156, 0x0002.  Make sure that the
> vendor string is "Intersil" or "INTERSIL"
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
>  drivers/net/wireless/hostap/hostap_cs.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)

Why was this not CC'd to the wireless maintainer and netdev list?

	Jeff


