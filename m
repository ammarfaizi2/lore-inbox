Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWCCFzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWCCFzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 00:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751697AbWCCFzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 00:55:47 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:61859 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751214AbWCCFzq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 00:55:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XQzNBX39YnTZvsgDmomcBaTbg/0Rl3VTxAI2biVjDgHcACP8WtBk5HaJ1ltRs7KUh9GThkLSyGk38azWXHY68Cus7+1ySUyNaVCCV0EBx763aQ4wZH1HmWiOT9OZKfHl1pxtdFLTGGG4nRXsQWbcdveNS9pe1tJXysp03izo1sI=
Message-ID: <503e0f9d0603022155j2570314jffcdf84060e336f2@mail.gmail.com>
Date: Fri, 3 Mar 2006 11:25:45 +0530
From: "tim tim" <tictactoe.tim@gmail.com>
To: "Andrew Haninger" <ahaning@gmail.com>
Subject: Re: modutils
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <105c793f0603022145t55f25cedpd6c40efd703530f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <503e0f9d0603022041q717ae7cdo8539ba8f508dd681@mail.gmail.com>
	 <105c793f0603022138u6dca326ewa3b5d476f4c4ef48@mail.gmail.com>
	 <503e0f9d0603022141l5dc9a88ds380dd9dd2ba22c41@mail.gmail.com>
	 <105c793f0603022145t55f25cedpd6c40efd703530f5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okayy let me give a breif explanatin of what i am doing..

here i am trying to install 2.6.10 kernel on the system that was fully
installed RedHat EL3 (2.4.21). we followed this procedure..

make xconfig and selected loadable modules support along with the
filesystem (ext3) support.

then make bzImage
make modules

so far it works fine  and
make modules_install

it tries to install some .. modules .. after that it prints like..

#######################################################
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_mark.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_multiport.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_owner.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_pkttype.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_recent.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_state.ko
depmod:         need_ip_conntrack
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_tcpmss.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_tos.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/ipt_ttl.ko
depmod:         ipt_register_match
depmod:         ipt_unregister_match
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/iptable_filter.ko
depmod:         ipt_unregister_table
depmod:         ipt_do_table
depmod:         ipt_register_table
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/iptable_mangle.ko
depmod:         ipt_unregister_table
depmod:         ipt_do_table
depmod:         ipt_register_table
depmod: *** Unresolved symbols in
/lib/modules/2.6.10/kernel/net/ipv4/netfilter/iptable_nat.ko
depmod:         ipt_unregister_table
depmod:         need_ip_conntrack


######################################################

its just a part of output ..  hope u r clear enough of info.. then let
me know how to solve it.. and even one more question..

to install a kernel .. is it necessary to have a fully installed
system.. and whether the kernel 2.6.10 can be installed on Fedora Core
3..
