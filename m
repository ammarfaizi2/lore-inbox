Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWBCQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWBCQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 11:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWBCQ04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 11:26:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:9021 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751202AbWBCQ0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 11:26:55 -0500
Message-ID: <43E384B1.1000404@openvz.org>
Date: Fri, 03 Feb 2006 19:28:33 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Dave Hansen <haveblue@us.ibm.com>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled case
References: <43E22B2D.1040607@openvz.org> <43E23398.7090608@openvz.org> <1138899951.29030.30.camel@localhost.localdomain> <20060203105202.GA21819@ms2.inr.ac.ru> <43E35105.3080208@fr.ibm.com> <43E36319.7020803@sw.ru> <43E37983.9080202@fr.ibm.com>
In-Reply-To: <43E37983.9080202@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That is an interesting concept because it could probably be used to satisfy
> all parties. It seems that everyone has his own idea on what a container
> should "feel" like, in term of pid virtualisation and container parent hood
> also, at least. May be there is not a unique model.
Yes, it is some concept of abstract container. I will send a series of 
patches for this today CCing you, so that you could take a look and 
better understand what and how it cab be used for in our opinion.

> Just booted 2.6.15-openvz.025stab014, I'm going to have a look at the
> concepts you put place.
OpenVZ conception is that a VPS is something like a container, with 
virtualized TCP/IP, netfilters, rounting, IPC, process tree and so on.
It looks almost exactly like a standalone system. This container is easy 
to checkpoint and restore since it has obvious boundaries and is isolated.

Feel free to ask any questions on the forum or directly from me.

Kirill

