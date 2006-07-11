Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWGKXgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWGKXgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWGKXgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:36:01 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:2948 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932243AbWGKXgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:36:00 -0400
Message-ID: <44B435DE.4040708@vandrovec.name>
Date: Wed, 12 Jul 2006 01:35:58 +0200
From: Petr Vandrovec <petr@vandrovec.name>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: cs, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: torvalds@osdl.org, akpm@osdl.org, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT *] Remove inclusion of obsolete <linux/config.h>
References: <1152631729.3373.197.camel@pmac.infradead.org>
In-Reply-To: <1152631729.3373.197.camel@pmac.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> Linus, please pull from git://git.infradead.org/~dwmw2/killconfig.h.git

> Sam thinks it should be a #warning instead, even though it's been
> unnecessary to include config.h for about eight months now. If you
> agree, pull from git://git.infradead.org/~dwmw2/woundconfig.h.git
> instead -- that differs from the first in that it turns config.h into a
> #warning instead.

Well, it is probably unnecessary to include config.h for about eight months, but 
as it is not present in feature-removal-schedule.txt I've missed it.  Thanks for 
pointing it out...

FYI, fortunately (for you, unfortunately for VMware) 2.6.18's already broke our 
build script due to UTS_RELEASE being moved to separate file, so from VMware's 
viewpoint killconfig.h.git will not do any additional damage...

> Please pull one or the other, as you see fit.

								Petr Vandrovec

