Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317893AbSHGNor>; Wed, 7 Aug 2002 09:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHGNor>; Wed, 7 Aug 2002 09:44:47 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:4847 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317893AbSHGNoq>; Wed, 7 Aug 2002 09:44:46 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0208070906270.18786-100000@rancor.yyz.somanetworks.com> 
References: <Pine.LNX.4.33.0208070906270.18786-100000@rancor.yyz.somanetworks.com> 
To: "Scott Murray" <scottm@somanetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 07 Aug 2002 14:48:23 +0100
Message-ID: <22223.1028728103@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


scottm@somanetworks.com said:
>  However, it's entirely possible that you will be allocated resource
> ranges that are intermingled with the ranges that are behind other
> bridges or devices.  There's no sane way to program the hotplug
> bridge's BARs in such a situation. 

Why? Can't you just forward transactions for the whole of the range, 
including some addresses which are actually behind other bridges?

--
dwmw2


