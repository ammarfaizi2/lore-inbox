Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266568AbUGPUlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUGPUlg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUGPUlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:41:36 -0400
Received: from mail.enyo.de ([212.9.189.167]:64530 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266568AbUGPUle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:41:34 -0400
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior
 2.6.7/-mm1
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com>
	<1089054013.15671.48.camel@dhcppc4>
	<pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de>
	<slrncfb55n.dkv.jgoerzen@christoph.complete.org>
	<slrncfb55n.dkv.jgoerzen@christoph.complete.org>
	<87oemhot7l.fsf@deneb.enyo.de>
	<E1BlOpX-0005AW-00@chiark.greenend.org.uk>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 16 Jul 2004 22:41:33 +0200
In-Reply-To: <E1BlOpX-0005AW-00@chiark.greenend.org.uk> (Matthew Garrett's
 message of "Fri, 16 Jul 2004 10:16:35 +0100")
Message-ID: <87vfgnelc2.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Garrett:

> Florian Weimer <fw@deneb.enyo.de> wrote:
>
>>  - After terminating the X11 server, other devices on the sharded IRQ
>>    11 are dead (most prominently, e1000 and USB).
>
> Try the last proposed patch along with the ACPI_NOT_ISR patch from
> http://bugzilla.kernel.org/show_bug.cgi?id=2643 and see if it makes any
> difference. Without the sysfs support, the 8259 never gets set for level
> triggering on resume.

Unfortunately, the system still doesn't come back from
suspend-to-RAM. 8-(
