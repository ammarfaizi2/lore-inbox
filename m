Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWHRKDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWHRKDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWHRKDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:03:55 -0400
Received: from mail.suse.de ([195.135.220.2]:60906 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751336AbWHRKDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:03:54 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 2/5] -fstack-protector feature: Add the Kconfig option
Date: Fri, 18 Aug 2006 13:08:07 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <1155746902.3023.63.camel@laptopd505.fenrus.org> <1155747038.3023.67.camel@laptopd505.fenrus.org>
In-Reply-To: <1155747038.3023.67.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608181308.07752.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 18:50, Arjan van de Ven wrote:
> Subject: [patch 2/5] Add the Kconfig option for the stackprotector feature
> From: Arjan van de Ven <arjan@linux.intel.com>
>
> This patch adds the config options for -fstack-protector.

Normally it's better to add the CONFIG options after the code or 
at the same time. Otherwise binary searches later can break

Also can the CC be dropped in the option? It makes it too long.

-Andi

>
