Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUEaOzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUEaOzz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 10:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUEaOzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 10:55:55 -0400
Received: from lvs00-fl-n04.valueweb.net ([216.219.253.138]:7822 "EHLO
	ams004.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S264641AbUEaOzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 10:55:54 -0400
Message-ID: <40BB474F.9050503@coyotegulch.com>
Date: Mon, 31 May 2004 10:55:11 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040522)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
References: <200405310152.i4V1qNk03732@mailout.despammed.com>
In-Reply-To: <200405310152.i4V1qNk03732@mailout.despammed.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ndiamond@despammed.com wrote:
> And does anyone know a really safe method?

I recently built a 64-bit fixed-point library for a client, which they
used in a device driver. I'd suggest following a similar pattern, thus
avoiding the entire issues of "floating-point" in the kernel.

..Scott


-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

