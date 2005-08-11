Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVHKIwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVHKIwW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVHKIwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:52:22 -0400
Received: from denise.shiny.it ([194.20.232.1]:11658 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S1030228AbVHKIwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:52:21 -0400
Date: Thu, 11 Aug 2005 10:52:16 +0200 (CEST)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: n l <walking.to.remember@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why the interrupt handler should be marked "static" for it is
 never called directly from another file.
In-Reply-To: <6b5347dc05081101334c1a6e3c@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0508111049010.5385@denise.shiny.it>
References: <6b5347dc05081101334c1a6e3c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Aug 2005, n l wrote:

> could you explain its reason for using static ?

Anything which is never referenced from another file should be
static in order to keep namespace pollution low.


--
Giuliano.
