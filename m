Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbTFMU7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTFMU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 16:59:18 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30646
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265530AbTFMU7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 16:59:17 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: joe.korty@ccur.com
Cc: Paul Mackerras <paulus@samba.org>, Patrick Mochel <mochel@osdl.org>,
       Robert Love <rml@tech9.net>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030613195717.GA26221@tsunami.ccur.com>
References: <1055460564.662.339.camel@localhost>
	 <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
	 <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
	 <1055493713.5169.10.camel@dhcp22.swansea.linux.org.uk>
	 <16105.44765.930081.44739@cargo.ozlabs.ibm.com>
	 <1055511099.5162.53.camel@dhcp22.swansea.linux.org.uk>
	 <20030613195717.GA26221@tsunami.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055538620.6592.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jun 2003 22:10:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-13 at 20:57, Joe Korty wrote:
> > Turns out its 486 and higher, so you win. 
> 
> 
> Perhaps it's time to remove 386 support from 2.5?  Users
> of very old machines can stick with 2.0, 2.2 or 2.4.

You have to solve these problems generally anyway, and lots of
other platforms have limited locking functions. What it means
is that all sane PC hardware can do it efficiently

