Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVLBXGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVLBXGa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 18:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLBXGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 18:06:30 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:15754 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1751048AbVLBXG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 18:06:29 -0500
Message-ID: <4390CD4F.105@wolfmountaingroup.com>
Date: Fri, 02 Dec 2005 15:40:15 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
Cc: netdev@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ip / ifconfig redesign
References: <200512022253.19029.a1426z@gawab.com>
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:

>The current ip / ifconfig configuration is arcane and inflexible.  The reason 
>being, that they are based on design principles inherited from the last 
>century.
>
>In a GNU/OpenSource environment, OpenMinds should not inhibit themselves 
>achieving new design-goals to enable a flexible non-redundant configuration.
>
>Specifically, '#> ip addr ' exhibits this issue clearly, by requiring to 
>associate the address to a link instead of the other way around.
>
>Consider this new approach for better address management:
>1. Allow the definition of an address pool
>2. Relate links to addresses
>3. Implement to make things backward-compatible.
>
>The obvious benefit here, would be the transparent ability for apps to bind 
>to addresses, regardless of the link existence.
>
>Another benefit includes the ability to scale the link level transparently, 
>regardless of the application bind state.
>
>And there may be many other benefits... (i.e. 100% OSI compliance)
>
>--
>Al
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Just what we need, another broken utility without backward 
compatibility. Make certain you preserve the existing commands so the whole
planet isn't broken as a result.

Jeff
