Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTLBQxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTLBQxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:53:39 -0500
Received: from fmr04.intel.com ([143.183.121.6]:34975 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262303AbTLBQxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:53:38 -0500
Subject: Re: IDE-SCSI oops in 2.6.0-test11
From: Len Brown <len.brown@intel.com>
To: ross.alexander@uk.neceur.com
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <OFCDE312E0.4BD86A49-ON80256DF0.004D17F7-80256DF0.004DA592@uk.neceur.com>
References: <OFCDE312E0.4BD86A49-ON80256DF0.004D17F7-80256DF0.004DA592@uk.neceur.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070384005.2495.2.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Dec 2003 11:53:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-02 at 09:08, ross.alexander@uk.neceur.com wrote:
> ACPI works fine but LAPIC doesn't.

Does it work if you build ACPI into the kernel, but exclude local APIC?

CONFIG_ACPI=y
CONFIG_X86_UP_APIC=n
CONFIG_X86_LOCAL_APIC=n

Or perhaps the "nolapic" boot-time option is effective?


