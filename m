Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWCEQfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWCEQfa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 11:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWCEQfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 11:35:30 -0500
Received: from khc.piap.pl ([195.187.100.11]:12804 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932222AbWCEQf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 11:35:29 -0500
To: dmitrmax@rain.ifmo.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with reading DVD-RW media
References: <200603051617.32455.dmitrmax@rain.ifmo.ru>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 05 Mar 2006 17:35:24 +0100
In-Reply-To: <200603051617.32455.dmitrmax@rain.ifmo.ru> (Max Dmitrichenko's
 message of "Sun, 5 Mar 2006 16:17:32 +0300")
Message-ID: <m3zmk4g88j.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Dmitrichenko <dmitrmax@rain.ifmo.ru> writes:

> The interest thing is that readcd still produces a valid image from this disc
> and it has correct MD5 sum. So the problem is not in the media. Furthermore,
> the disc can be perfectly read from Win2K in the VMWare environment when host
> OS is my linux and independent of DMA settings.

Read-ahead + number of sectors not set I'd bet. Padding the image with
some amount of empty sectors would probably help.

I.e., the discs are ok, the read procedure is faulty.
-- 
Krzysztof Halasa
