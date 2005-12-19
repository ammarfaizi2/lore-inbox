Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbVLSJjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbVLSJjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 04:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVLSJjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 04:39:23 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:61856 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932711AbVLSJjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 04:39:23 -0500
Message-ID: <43A680B1.50502@aitel.hist.no>
Date: Mon, 19 Dec 2005 10:43:13 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Rompf <stefan@loplof.de>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k/4k stacks
References: <200512181149.02009.stefan@loplof.de> <1134904884.9626.7.camel@laptopd505.fenrus.org> <200512181304.38054.stefan@loplof.de>
In-Reply-To: <200512181304.38054.stefan@loplof.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf wrote:

>Wrong. The probability that an interrupt happens just during the codepath with 
>highest stack usage is very small. Anyway CONFIG_DEBUG_STACKOVERFLOW is not 
>enabled in 2.6.14.4 i386 defconfig. Don't know about vendor kernel kernels 
>though.
>  
>
Well, the interrupts have their own stack (if using 4k stacks) so
the interrupt timing shouldn't matter. 

Helge Hafting
