Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVCNWls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVCNWls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 17:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVCNWh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:37:56 -0500
Received: from newmail.linux4media.de ([193.201.54.81]:53481 "EHLO l4m.mine.nu")
	by vger.kernel.org with ESMTP id S262034AbVCNWfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:35:51 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Re: 2.6.11-mm3 - DRM/i915 broken
Date: Mon, 14 Mar 2005 23:30:40 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050312034222.12a264c4.akpm@osdl.org> <42360820.702@ens-lyon.org>
In-Reply-To: <42360820.702@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503142330.42556.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 March 2005 22:54, Brice Goglin wrote:
> DRM/i915 does not work on my Dell Dimension 3000 (i865 chipset).
> It's the first -mm kernel I try on this box. I don't whether previous -mm
> worked or not. Anyway, 2.6.11 works great.

You may want to try compiling without CONFIG_4KSTACKS. I've run into (not 100% 
reproducable) problems with i855 [and i865 is using a lot of the same code] 
and 4K stacks before...

LLaP
bero
