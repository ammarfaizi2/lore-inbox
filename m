Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTGOEmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 00:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTGOEmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 00:42:18 -0400
Received: from palrel12.hp.com ([156.153.255.237]:33187 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261944AbTGOEmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 00:42:17 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16147.35233.333351.492981@napali.hpl.hp.com>
Date: Mon, 14 Jul 2003 21:57:05 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
In-Reply-To: <20030714214510.17e02a9f.davem@redhat.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
	<20030714214510.17e02a9f.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 14 Jul 2003 21:45:10 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Mon, 14 Jul 2003 21:42:40 -0700 "Feldman, Scott"
  DaveM> <scott.feldman@intel.com> wrote:

  >> > Note that I had to move the e1000_check_options() call to a >
  >> slighly earlier place.  You may want to double-check that > it's
  >> really OK.

  >> I'm not too keen on adding another module parameter.  Maybe a
  >> CONFIG_E1000_TSO option?

  DaveM> Extend ethtool please :-)

ethtool would be ideal, agreed.

I absolutely think that this should be a runtime option, not a
compile-time option.

	--david
