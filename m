Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTDPQme (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTDPQme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:42:34 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:9636 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264499AbTDPQmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:42:32 -0400
Message-ID: <3E9D8A68.5050207@colorfullife.com>
Date: Wed, 16 Apr 2003 18:52:56 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: jamal <hadi@cyberus.ca>, Catalin BOIE <util@deuroconsult.ro>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] qdisc oops fix
References: <20030415084706.O1131@shell.cyberus.ca> <Pine.LNX.4.53.0304160838001.25861@hosting.rdsbv.ro> <20030416072952.E4013@shell.cyberus.ca> <3E9D755A.8060601@colorfullife.com> <20030416160606.GA32575@louise.pinerecords.com>
In-Reply-To: <20030416160606.GA32575@louise.pinerecords.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:

>The original backtrace as provided by Martin Volf does not contain
>any weird addresses such as 0xd081ecc7 above:
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=105013596721774&w=2
>  
>
Thanks.
The bug was caused by sch_tree_lock() in htb_change_class().
2.4.21-pre7 contains a fix.

--
    Manfred


