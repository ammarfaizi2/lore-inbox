Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVCKEQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVCKEQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVCKEIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:08:34 -0500
Received: from ozlabs.org ([203.10.76.45]:32232 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263169AbVCKECC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:02:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16945.6211.331369.393573@cargo.ozlabs.ibm.com>
Date: Fri, 11 Mar 2005 15:02:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: ncunningham@cyclades.com
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <DaveJ@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jerome Glisse <j.glisse@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] AGP support for powermac G5
In-Reply-To: <1110513167.3049.45.camel@desktop.cunningham.myip.net.au>
References: <16945.2617.625095.404994@cargo.ozlabs.ibm.com>
	<1110513167.3049.45.camel@desktop.cunningham.myip.net.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham writes:

> No power management support? :>

The suspend/resume methods are in the pci_driver struct, not the
agp_bridge_driver struct.  Not that we have suspend/resume on the G5
yet.

Paul.
