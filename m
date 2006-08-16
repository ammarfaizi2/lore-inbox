Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWHPRk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWHPRk2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWHPRk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:40:28 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:8661 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751221AbWHPRk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:40:27 -0400
Date: Wed, 16 Aug 2006 19:39:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix crash case
In-Reply-To: <1155746131.24077.363.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0608161938320.20450@yvahk01.tjqt.qr>
References: <1155746131.24077.363.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>If we are going to BUG() not panic() here then we should cover the case
>of the BUG being compiled out

Bug can be compiled out? Ah well I much rather like this patch because of 
the previous busy-looping, heating CPUs unnecessarily. (There was a thread, 
about that, too.)


Jan Engelhardt
-- 
