Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261688AbSJYXjS>; Fri, 25 Oct 2002 19:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbSJYXjS>; Fri, 25 Oct 2002 19:39:18 -0400
Received: from oak.sktc.net ([208.46.69.4]:40411 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S261688AbSJYXjR>;
	Fri, 25 Oct 2002 19:39:17 -0400
Message-ID: <3DB9D789.4020101@sktc.net>
Date: Fri, 25 Oct 2002 18:45:13 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Jeff Garzik <jgarzik@pobox.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
References: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>	<3DB9CC5D.7000600@pobox.com>  <3DB9D1FE.5010607@sktc.net> <1035588310.734.4165.camel@phantasy>
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE7086@fmsmsx103.fm.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>
> If there are subcores, then I think there must be some major core. 

I would assert that, at least in the case of the P4, there IS a "major 
core", as the 2 subcores share L1 and bus controller access, as well as 
several other parts of the chip.

I beleive this is to some extent the case in the Power4 modules - that 
each module contains resources shared by the execution units. However, I 
might be full of it, and since there are plenty of @ibm.com's here I 
expect to be corrected shortly....



