Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTFMIbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbTFMIbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:31:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3760
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265261AbTFMIam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:30:42 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Patrick Mochel <mochel@osdl.org>, Robert Love <rml@tech9.net>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
References: <1055460564.662.339.camel@localhost>
	 <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
	 <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055493713.5169.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 09:41:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-13 at 00:40, Paul Mackerras wrote:
> You can't do atomic_inc_and_read on 386.  You can on cpus that have

lock xaddl $1, [foo]

