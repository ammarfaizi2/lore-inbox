Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTGAREq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTGAREq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:04:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41660 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263025AbTGAREk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:04:40 -0400
Message-ID: <3F01C1B0.9030901@us.ibm.com>
Date: Tue, 01 Jul 2003 10:15:28 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Salmon <jsalmon@thesalmons.org>
CC: "David S. Miller" <davem@redhat.com>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, jmorris@redhat.com
Subject: Re: negative tcp_tw_count and other TIME_WAIT weirdness?
References: <200307010025.h610PGmX007656@river.fishnet>	<20030701.012107.42800729.davem@redhat.com> <m3brwedvd9.fsf@river.fishnet>
In-Reply-To: <m3brwedvd9.fsf@river.fishnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Salmon wrote:

> Another question - is there any chance that this bug could be
> responsible for a slowdown in network processing.  Some of my machines
> get themselves into a state in which their ability to serve
> network traffic (they're running squid) is significantly reduced -
> perhaps by a factor of two.  I wish I had more specific data, but at
> this point it's a mystery.  What I'm really wondering is whether
> there's any chance at all that this kernel bug could be behind my
> performance problem, or should I look elsewhere.
> 
> TIA,
> John Salmon

John, thanks for the earlier info you gave me, but
could you also give us your netstat -s output? For
example, are you seeing a lot of tcp memory pressure?
aborts? failures?

thanks,
Nivedita


