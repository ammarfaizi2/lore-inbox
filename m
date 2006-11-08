Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754502AbWKHKCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbWKHKCB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 05:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754510AbWKHKCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 05:02:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47082 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754502AbWKHKCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 05:02:00 -0500
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: Andrew Morton <akpm@osdl.org>, Roland Dreier <rdreier@cisco.com>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <4551A970.9090704@qumranet.com>
References: <454E4941.7000108@qumranet.com>
	 <20061107204440.090450ea.akpm@osdl.org>	<adafycuh77b.fsf@cisco.com>
	 <455183EA.2020405@qumranet.com> <20061107233323.c984fa9b.akpm@osdl.org>
	 <45519033.3060409@qumranet.com>
	 <1162978754.3138.266.camel@laptopd505.fenrus.org>
	 <4551A970.9090704@qumranet.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 08 Nov 2006 11:01:41 +0100
Message-Id: <1162980101.3138.276.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The problem with that is that the test comes too late: after we've 
> configured.  Andrew wants to keep allmodconfig working, and for that we 
> need to deselect CONFIG_KVM before compilation starts.

not really. You can also select to just not compile kvm at all *from the
Makefile*
> 
> gcc.*protector.sh only affects the Makefile, not the configuration, AFAICT.

but it is the Makefile that goes into the kvm directory and compiles
stuff!

yes it's ugly and not so elegant, but it's effective and you can warn
bigtime via nasty messages if you want ;)


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

