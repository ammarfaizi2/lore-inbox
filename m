Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267028AbSL3WAF>; Mon, 30 Dec 2002 17:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267036AbSL3WAF>; Mon, 30 Dec 2002 17:00:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20866
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267028AbSL3WAE>; Mon, 30 Dec 2002 17:00:04 -0500
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200212301645.50278.tomlins@cam.org>
References: <200212301645.50278.tomlins@cam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Dec 2002 22:50:08 +0000
Message-Id: <1041288608.13956.173.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very interesting, but I'll note there are actually two groupings to
solve - per user and per threadgroup. Also for small numbers of threads
you don't want to punish a task and ruin its balancing across CPUs

Have you looked at the per user fair share stuff too ?

