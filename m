Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUHIMc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUHIMc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUHIMc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:32:56 -0400
Received: from gate.corvil.net ([213.94.219.177]:269 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S266538AbUHIMct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:32:49 -0400
Message-ID: <41176EC3.70202@draigBrady.com>
Date: Mon, 09 Aug 2004 13:32:03 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Hamie <hamish@travellingkiwi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cs using 100% CPU
References: <40FA4328.4060304@travellingkiwi.com>	 <20040806202747.H13948@flint.arm.linux.org.uk>	 <4113DD20.1010808@travellingkiwi.com> <1091917597.19077.38.camel@localhost.localdomain> <4115EC6C.5040608@travellingkiwi.com> <41174A95.3050705@grupopie.com>
In-Reply-To: <41174A95.3050705@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> I've never seen a CF card that supported DMA (and I've worked with 
> several brands). Compact Flash cards have several modes of operation and 
> only one of this modes is "IDE-compatible".

The newer ones do. I've a SanDisk SDCFB-64-201-80 that
hangs on boot because it reports that it supports DMA
but the ide adapter I use does not connect the DMA request
and grant signals. A work around is to boot with ide=nodma
however this is system wide.

Pádraig.
