Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268029AbUIBJ1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268029AbUIBJ1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUIBJY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:24:27 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:41091 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S268029AbUIBJYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:24:03 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: adaplas@pol.net
Subject: Re: 2.6.9-rc1: scrolling with tdfxfb 5 times slower
Date: Thu, 2 Sep 2004 11:26:39 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408312133.40039.ornati@fastwebnet.it> <200409011355.52999.ornati@fastwebnet.it> <200409020420.55269.adaplas@hotpop.com>
In-Reply-To: <200409020420.55269.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021126.39568.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 September 2004 22:20, Antonino A. Daplas wrote:
> >
> > BUT with CONFIG_FB_3DFX_ACCEL enabled I get strange video
> > "corruptions" (like bitmaps with random colors) that go away simply
> > swithcing to another console and than back to the previous.
>
> And another suggestion:
>
> Try to comment out FBINFO_HWACCEL_COPYAREA.

this has the only effect of slowing down the scrolling (not too much)... so 
the "copy area" routine of tdfxfb driver seems fine

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r3)
