Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272365AbTHNNrj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 09:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272366AbTHNNrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 09:47:39 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:32508 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S272365AbTHNNri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 09:47:38 -0400
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030814122845.GA2264@puettmann.net>
References: <20030813123119.GA25111@puettmann.net>
	 <16186.14686.455795.927909@gargle.gargle.HOWL>
	 <1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
	 <20030814122845.GA2264@puettmann.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060868835.5971.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 14 Aug 2003 14:47:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-14 at 13:28, Ruben Puettmann wrote:
> > This isnt sufficient because some of the SMM traps off the FN-key 
> > sequences also crash thinkpads if APIC is enabled. Basically *dont use
> > local apic* except on SMP.
> 
> sorry but why breaks this all under linux? O.K im not a friend if
> windows but on the preinstalled windowsXP it runs all fine.
> 
> Is this a problem of manpower or missing spec's? 

The system isnt designed to run with APIC enabled it seems. There is no
reason for the BIOS to handle this because its not a normal setup and
given the horrors of SMM BIOS code I suspect they had enough on their
hands anyway.


