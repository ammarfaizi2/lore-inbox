Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTKYT2z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 14:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbTKYT2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 14:28:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:46725 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbTKYT2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 14:28:54 -0500
Date: Tue, 25 Nov 2003 11:28:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
Message-ID: <20031125112845.A3067@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.44.0311251158110.2870-100000@chimarrao.boston.redhat.com> <3FC3A797.4060108@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3FC3A797.4060108@softhome.net>; from filia@softhome.net on Tue, Nov 25, 2003 at 08:03:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ihar 'Philips' Filipau (filia@softhome.net) wrote:
>    I cannot tell what it does - but name 'security_vm_enough_memory()' 
> sounds promising ;-)

This allows a security module to verify that a process can add mapping
for the new pages it's trying to grab.  And can be used to control
overcommit.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
