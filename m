Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265715AbUFSNcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUFSNcS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUFSNcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:32:18 -0400
Received: from fmr11.intel.com ([192.55.52.31]:4561 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265715AbUFSNcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:32:15 -0400
Subject: Re: 2.6.7 NULL pointer dereference during boot
From: Len Brown <len.brown@intel.com>
To: George Garvey <tmwg-linuxknl@inxservices.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FE6B4@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FE6B4@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1087651896.4486.220.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Jun 2004 09:31:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 20:29, George Garvey wrote:

> ACPI: Subsystem revision 20040326
> Unable to handle kernel NULL pointer dereference

Probably it is this failure:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=125841

known workarounds:

CONFIG_SCHED_SMT=n
"acpi=off"
"acpi=ht"
"maxcpus=1"



