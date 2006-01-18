Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWARUoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWARUoz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWARUoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:44:55 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:19573 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030436AbWARUoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:44:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=TZrqW32lVCoKuFwahqLcZlEp7TqmdcTVtvsIdvJWs0UoP6+p6Tbvqm87W9EzpIKJZnkad8UTlepYVnPN/EWuvJ+5NdvtcLyK/Eau3zRIznwyDnndEh9jVsszZ5IPjb1C2l6F4lIvyPBtqkXafD5On39/T7+cWp6BC1VZLh0QwE4=
Date: Thu, 19 Jan 2006 00:02:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: add __kernel_old_dev_t for nfsd
Message-ID: <20060118210206.GI12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-arm26/posix_types.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--- a/include/asm-arm26/posix_types.h
+++ b/include/asm-arm26/posix_types.h
@@ -44,6 +44,7 @@ typedef unsigned int		__kernel_gid32_t;
 
 typedef unsigned short		__kernel_old_uid_t;
 typedef unsigned short		__kernel_old_gid_t;
+typedef unsigned short		__kernel_old_dev_t;
 
 #ifdef __GNUC__
 typedef long long		__kernel_loff_t;

