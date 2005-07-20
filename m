Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVGTPjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVGTPjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 11:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVGTPjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 11:39:19 -0400
Received: from mail.elvees.com ([80.92.98.198]:53221 "EHLO narwhal.elvees.dmz")
	by vger.kernel.org with ESMTP id S261164AbVGTPjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 11:39:18 -0400
From: Samium Gromoff <deepfire@elvees.com>
To: linux-kernel@vger.kernel.org
Subject: Re: restricting skb allocation to a specific zone
Date: Wed, 20 Jul 2005 19:38:37 +0400
User-Agent: KMail/1.7.2
References: <200507201926.15662.deepfire@elvees.com>
In-Reply-To: <200507201926.15662.deepfire@elvees.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201938.37119.deepfire@elvees.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The hardware requirement i have dictate me that i have to have the skb`s
> allocated in a specific zone, which is unfortunately neither contiguous
> with GFP_NORMAL nor placed at the beginning of the physical memory.

er, ZONE_NORMAL, obviously
