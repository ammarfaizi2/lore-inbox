Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUI2Q7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUI2Q7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUI2Q7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:59:51 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:8073 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268719AbUI2Qzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:55:39 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org, sboyce@blueyonder.co.uk
Subject: Re: 2.6.9-rc2-mm4 and nvidia 1.0-6111
Date: Wed, 29 Sep 2004 13:55:20 -0300
User-Agent: KMail/1.7
References: <415A6EE6.1090404@blueyonder.co.uk>
In-Reply-To: <415A6EE6.1090404@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409291355.20281.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce wrote:
> Any help appreciated, also posted to nvidia forum.

I did revert these patches:

convert-references-to-remap_page_range-under-arch-and-documentation-to-remap_pfn_range.patch
convert-users-of-remap_page_range-under-drivers-and-net-to-use-remap_pfn_range.patch
convert-users-of-remap_page_range-under-include-asm--to-use-remap_pfn_range.patch
convert-users-of-remap_page_range-under-sound-to-use-remap_pfn_range.patch
for-mm-only-remove-remap_page_range-completely.patch
introduce-remap_pfn_range-to-replace-remap_page_range.patch


HTH,
Norberto
