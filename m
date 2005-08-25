Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVHYOQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVHYOQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVHYOQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:16:55 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:14277
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S965015AbVHYOQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:16:54 -0400
Subject: Re: [PATCH 2.6.13-rc6] dcdbas: add Dell Systems Management Base
	Driver with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: David Greaves <david@dgreaves.com>
Cc: Doug Warzecha <Douglas_Warzecha@dell.com>, matt_domsch@dell.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <430DCB58.1090107@dgreaves.com>
References: <20050820225052.GA5042@sysman-doug.us.dell.com>
	 <430DCB58.1090107@dgreaves.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 09:16:48 -0500
Message-Id: <1124979408.13113.18.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please download libsmbios 0.10.0-beta1 and send the "dumpCmos" output
from your machine. Please send it to the libsmbios devel mailing list.
>From that output, I can tell you if this token is available on that
machine. If that token is available, then yes, you can set that feature.

libsmbios can be obtained from http://linux.dell.com/libsmbios/main/

dumpCmos is part of "make minimal", so you don't need any other libs
present to compile. It is found under bins/output/ after compile.
(alternatively, install the libs and bins rpms)
--
Michael

On Thu, 2005-08-25 at 14:44 +0100, David Greaves wrote:
> 
> I have a Dell SC420
> Is there a way (based around this patch) to allow users to enable and
> set the auto-power-on BIOS feature?
> (ie tell the BIOS to power on at 3:40am, power the system down, watch
> it
> power up at 3:40am)
> 
> Normally I'd use 'nvram-wakeup' but it dosen't understand the Dell
> BIOS.
> 
> If so what I'd _like_ to do is send a patch to nvram-wakeup that tests
> for this capability and uses it if it's there.
> 
> David
> 

