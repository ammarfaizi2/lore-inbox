Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUGVJEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUGVJEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUGVJD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:03:58 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:28313 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266837AbUGVJCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:02:47 -0400
Date: Thu, 22 Jul 2004 11:02:46 +0200
From: bert hubert <ahu@ds9a.nl>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: crossgcc <crossgcc@sources.redhat.com>,
       "'Hollis Blanchard'" <hollisb@us.ibm.com>,
       "'bertrand marquis'" <bertrand_marquis@yahoo.fr>,
       "'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
       "'Dan Kegel'" <dank@kegel.com>,
       "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No rule to make target `net/ipv4/netfilter/ipt_ecn.o'
Message-ID: <20040722090246.GA16725@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	crossgcc <crossgcc@sources.redhat.com>,
	'Hollis Blanchard' <hollisb@us.ibm.com>,
	'bertrand marquis' <bertrand_marquis@yahoo.fr>,
	"'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
	'Dan Kegel' <dank@kegel.com>,
	'Geert Uytterhoeven' <geert@linux-m68k.org>,
	"'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <313680C9A886D511A06000204840E1CF08F43050@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF08F43050@whq-msgusr-02.pit.comms.marconi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make[3]: *** No rule to make target
>  `net/ipv4/netfilter/ipt_ecn.o', needed by `net/ipv4/netfilter/built-in.o'.
> Stop.

This is the (somewhat questionable) use of ipt_ECN.c and ipt_ecn.c in the
linux kernel. Windows filesystems are case insensitive, and see this as one
file.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
