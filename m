Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVGENiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVGENiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVGENiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:38:50 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:15880 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261839AbVGENiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:38:15 -0400
Message-ID: <42CA8D44.8020301@rtr.ca>
Date: Tue, 05 Jul 2005 09:38:12 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Mike Waychison <mike@waychison.com>,
       Dmitry Torokhov <dtor@mail.ru>, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ALPS psmouse_reset on reconnect confusing Tecra M2
References: <42C9A69A.5050905@waychison.com> <200507041705.17626.dtor_core@ameritech.net>
In-Reply-To: <200507041705.17626.dtor_core@ameritech.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh.. that might explain some weirdness observed here, as well.

Thanks!

Dmitry Torokhov wrote:
>
> Please try the following patch:
> 
> 	http://www.ucw.cz/~vojtech/input/alps-suspend-typo
