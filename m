Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbREaN2r>; Thu, 31 May 2001 09:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263096AbREaN2g>; Thu, 31 May 2001 09:28:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42490 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261975AbREaN20>; Thu, 31 May 2001 09:28:26 -0400
Message-ID: <3B1646BD.C3A1CCFE@vnet.ibm.com>
Date: Thu, 31 May 2001 13:27:25 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net,
        bjorn.wesen@axis.com, trini@kernel.crashing.org
Subject: Re: Only 5 undocumented configuration symbols left
In-Reply-To: <20010530190744.A2027@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> The current list of symbols with missing help is very short. Here it is:
> 
> PPC port:

> CONFIG_IRQ_ALL_CPUS

This option gives the kernel permission to distribute IRQs across multiple CPUs.
Saying N here will route all IRQs to the first CPU. Generally SMP PowerMacs can
answer Y. SMP IBM CHRP boxes or Power3 boxes should say N for now.

Regards,

Tom


-- 
Tom Gall - PPC64                 "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
