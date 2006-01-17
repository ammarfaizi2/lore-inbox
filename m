Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWAQWV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWAQWV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 17:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWAQWV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 17:21:29 -0500
Received: from natfrord.rzone.de ([81.169.145.161]:37250 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S964865AbWAQWV2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 17:21:28 -0500
From: Stefan Rompf <stefan@loplof.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: wireless: recap of current issues (configuration)
Date: Tue, 17 Jan 2006 23:20:48 +0100
User-Agent: KMail/1.8
Cc: Sam Leffler <sam@errno.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <43CAABD4.3070004@errno.com> <1137355912.2520.97.camel@localhost>
In-Reply-To: <1137355912.2520.97.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601172320.49072.stefan@loplof.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag 15 Januar 2006 21:11 schrieb Johannes Berg:

> [iwconfig mode ...]
>
> Yeah, I agree with this, it is much cleaner to handle in the kernel.
> Think about the issues if you have a struct net_device that has 250
> bytes of "payload" for the struct virtual_sta_device in it and you want
> to switch that to a struct virtual_monitor_device. Icky.

Well, nobody forces you to allocate dev->priv together with the net_device, 
you can set and change this pointer yourself. So I don't see a problem here.

Stefan
