Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUHDQ3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUHDQ3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUHDQ3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:29:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43235 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267350AbUHDQ24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:28:56 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Sourav Sen" <souravs@india.hp.com>
Subject: Re: CONFIG_FORCE_MAX_ZONEORDER
Date: Wed, 4 Aug 2004 09:26:28 -0700
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
References: <012401c47a28$70fb62a0$39624c0f@asiapacific.cpqcorp.net>
In-Reply-To: <012401c47a28$70fb62a0$39624c0f@asiapacific.cpqcorp.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408040926.28467.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2004 6:39 am, Sourav Sen wrote:
> Hi,
>
> Is there a way of changing the value of MAX_ORDER
> using CONFIG_FORCE_MAX_ZOMEORDER? During 'make xconfig'
> I did not see a way. If I change it by hand in .config
> and then run make oldconfig, it gets changed back to
> the old value (== 18). The source version is 2.6.6
>
> And, if it matters here -- I am on ia64.

If you really want to change it, you'll have to edit arch/ia64/Kconfig and 
change FORCE_MAX_ZONEORDER.

Jesse
