Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbTDKSVA (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTDKSVA (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:21:00 -0400
Received: from palrel12.hp.com ([156.153.255.237]:19123 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261413AbTDKSU5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:20:57 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16023.2631.748820.401393@napali.hpl.hp.com>
Date: Fri, 11 Apr 2003 11:32:39 -0700
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: davidm@hpl.hp.com, alan@lxorguk.ukuu.org.uk, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: proc_misc.c bug
In-Reply-To: <20030411102946.685a907c.rddunlap@osdl.org>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
	<1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
	<20030410154902.32f48f9c.rddunlap@osdl.org>
	<32880.4.64.197.106.1050037303.squirrel@webmail.osdl.org>
	<16022.21891.554860.506152@napali.hpl.hp.com>
	<20030411102946.685a907c.rddunlap@osdl.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 11 Apr 2003 10:29:46 -0700, "Randy.Dunlap" <rddunlap@osdl.org> said:

  Randy> For kmalloc() failing, do you mean the first (large)
  Randy> kmalloc() or the repeated ones that grow in size each time?

I was concerned about the kmalloc() in interrupts_open().

	--david
