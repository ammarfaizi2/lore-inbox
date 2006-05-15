Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWEOTAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWEOTAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWEOTAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:00:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:33223 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932494AbWEOTA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:00:26 -0400
Date: Mon, 15 May 2006 21:00:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sej@sej.fr
cc: linux-kernel@vger.kernel.org
Subject: Re: Rlimit
In-Reply-To: <4468A4D7.10603@gmail.com>
Message-ID: <Pine.LNX.4.61.0605152059420.18520@yvahk01.tjqt.qr>
References: <6cN1B-3ky-5@gated-at.bofh.it> <6cN1B-3ky-3@gated-at.bofh.it>
 <4468A4D7.10603@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Of course !!
> But if you want to increase mlock size you can't do it !
> setrlimit can only decrease process limits !
> I repeat my question : How to set mlock process for non-root process ?
> sej
>
By running setrlimit from a root process. Even the 
limits from /etc/secuirty/limits.conf must be set _somehow_.

>> man setrlimit


Jan Engelhardt
-- 
