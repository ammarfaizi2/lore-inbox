Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTIOUEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 16:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbTIOUEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 16:04:33 -0400
Received: from fmr06.intel.com ([134.134.136.7]:6073 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261528AbTIOUE1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 16:04:27 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Intel PRO/1000 NIC
Date: Mon, 15 Sep 2003 13:04:14 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010124F04A@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel PRO/1000 NIC
Thread-Index: AcN7l0XyJUmxzfBiRB6AnU9Ji4dkxAALQxGQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Lisong Xu" <lxu2@unity.ncsu.edu>, <netdev@oss.sgi.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Sep 2003 20:04:15.0193 (UTC) FILETIME=[89C87C90:01C37BC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am sending UDP data from one PC to another PC directly 
> through a cross cable. The NIC of sender is Intel(r) PRO/1000 
> MT Server Adapter, and the NIC of receiver is on-board Intel 
> PRO/1000 (Dell PowerEdge 1600SC).

A dump of lspci -vvv, ethtool -i eth<x>, and ethtool -d eth<x> will tell
us the 8254x controller version you're using; the driver version; if
you're running PCI or PCI-X, and at what speed; and what you're sharing
the bus with.

Ethtool version 1.8: http://sf.net/projects/gkernel.
Latest e1000: http://sf.net/projects/e1000.

-scott
