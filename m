Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTGOEjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 00:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTGOEjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 00:39:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2000 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261874AbTGOEjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 00:39:35 -0400
Date: Mon, 14 Jul 2003 21:45:10 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [patch] e1000 TSO parameter
Message-Id: <20030714214510.17e02a9f.davem@redhat.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102229169@orsmsx402.jf.intel.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003 21:42:40 -0700
"Feldman, Scott" <scott.feldman@intel.com> wrote:

> > Note that I had to move the e1000_check_options() call to a 
> > slighly earlier place.  You may want to double-check that 
> > it's really OK.
> 
> I'm not too keen on adding another module parameter.  Maybe a
> CONFIG_E1000_TSO option?

Extend ethtool please :-)
