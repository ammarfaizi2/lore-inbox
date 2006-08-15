Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWHORlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWHORlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWHORlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:41:39 -0400
Received: from gateway-1237.mvista.com ([63.81.120.155]:6751 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1030372AbWHORli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:41:38 -0400
Message-ID: <44E20799.4060606@ru.mvista.com>
Date: Tue, 15 Aug 2006 21:42:49 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Roger Heflin <rheflin@atipa.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: What determines which interrupts are shared under Linux?
References: <44E1D760.6070600@atipa.com> <20060815173116.GQ7189@hygelac>
In-Reply-To: <20060815173116.GQ7189@hygelac>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Terence Ripperda wrote:
> we've seen a lot of problems on ck804 chipsets when multiple devices
> share level-triggered interrupts. I think some of the earlier sample
> bioses assumed that interrupts would be configured via ACPI, and when
> ACPI is not used, the interrupts end up as level-triggered instead of
> edge-triggered.

    Edge-triggered *shared* interrupts?! Now that sounds interesting (I'm not 
saying impossible).

WBR, Sergei
