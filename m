Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUCFCN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 21:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUCFCN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 21:13:57 -0500
Received: from palrel11.hp.com ([156.153.255.246]:45963 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261505AbUCFCNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 21:13:55 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16457.13280.667324.33914@napali.hpl.hp.com>
Date: Fri, 5 Mar 2004 18:13:52 -0800
To: davidm@hpl.hp.com
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       vojtech@suse.cz, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <16457.12968.365287.561596@napali.hpl.hp.com>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
	<16289.29015.81760.774530@napali.hpl.hp.com>
	<16289.55171.278494.17172@napali.hpl.hp.com>
	<3FA28C9A.5010608@pacbell.net>
	<16457.12968.365287.561596@napali.hpl.hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo-alert:

>>>>> On Fri, 5 Mar 2004 18:08:40 -0800, David Mosberger <davidm@linux.hpl.hp.com> said:

  David>  - HCD ends up dereferencing a bad pointer and ends up
  David> reading from address 0xf0000000, which on our ia64 machines
  David> is a read-only area, which then results in a machine-check
  David> abort
              ^^^^^^^^^
              make that "write-only"

  --david
