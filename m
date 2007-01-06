Return-Path: <linux-kernel-owner+w=401wt.eu-S1751447AbXAFSHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbXAFSHE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXAFSHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:07:04 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:60372 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbXAFSHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:07:01 -0500
Subject: Re: + paravirt-vmi-timer-patches.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: zach@vmware.com, ak@suse.de, chrisw@sous-sol.org, jeremy@xensource.com,
       rusty@rustcorp.com.au
In-Reply-To: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net>
References: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 10:06:00 -0800
Message-Id: <1168106760.26086.222.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 14:27 -0800, akpm@osdl.org wrote:
> +
> +config NO_IDLE_HZ
> +       bool
> +       depends on PARAVIRT
> +       default y
> +       help
> +         Switches the regular HZ timer off when the system is going
> idle.
> +         This helps a hypervisor detect that the Linux system is
> idle,
> +         reducing the overhead of idle systems. 


There is already a dynamic tick (NO_HZ) system in the -mm tree .. Given
that this implementation seems unnecessary. Why do you need another
different system to do this?

Daniel

