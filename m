Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVCYInY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVCYInY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 03:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCYInY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 03:43:24 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:30047 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261549AbVCYInW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 03:43:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GXWZZH3FEZPv+2Y3TLHbMB5K189h/CvWApYE1i8Axp6SJoGNiltskdSiIig7vhWWGlm/0czzoVAMzr16/urIunWhzyXknbM+v5aIN+/7wfyXLdQWL7i752PxzpNgFDnuGzYc3PHMDEix1x6meySHQP9Q6nkkvZlvDn2iHB+ZXU4=
Message-ID: <21d7e99705032500434957cd97@mail.gmail.com>
Date: Fri, 25 Mar 2005 19:43:21 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.12-rc1-mm2: crash in drm_agp_init
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20050325083035.GA1335@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050325083035.GA1335@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> ..with -rc1-mm2 I get crash during bootup, in some function called
> from drm_agp_init. I'm turned off CONFIG_AGP for now, and machine now
> boots as expected.

try -mm3 we had a bit of a patch clash between myself, Davej and
Adrian, I think -mm3 has all the fixes in it ..

Dave.
