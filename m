Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUC3NAk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUC3NAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:00:36 -0500
Received: from cpc3-cwma1-6-0-cust199.swan.cable.ntl.com ([81.101.209.199]:58070
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263588AbUC3NAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:00:35 -0500
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Len Brown <len.brown@intel.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1080598062.983.3.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <1080535754.16221.188.camel@dhcppc4>
	 <20040329052238.GD1276@alpha.home.local>  <1080598062.983.3.camel@dhcppc4>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Mar 2004 13:56:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-03-29 at 23:07, Len Brown wrote:
> Linux uses this locking mechanism to coordinate shared access
> to hardware registers with embedded controllers,
> which is true also on uniprocessors too.

If the ACPI layer simply refuses to run on a CPU without cmpxchg
then I can't see there being a problem, there don't appear to be
any 386 processors with ACPI

