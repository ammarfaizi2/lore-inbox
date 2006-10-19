Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWJSNgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWJSNgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWJSNgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:36:18 -0400
Received: from natblert.rzone.de ([81.169.145.181]:29586 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1161398AbWJSNgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:36:17 -0400
Message-ID: <45377ED3.9030001@bplan-gmbh.de>
Date: Thu, 19 Oct 2006 15:34:11 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
References: <20061019122802.GA26637@aepfle.de>
In-Reply-To: <20061019122802.GA26637@aepfle.de>
Content-Type: multipart/mixed;
 boundary="------------070801050702090409050507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070801050702090409050507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Olaf Hering wrote:
 > I get irq warnings with current Linus tree on Pegasos.
 > The EDID handling for radeonfb appears to be broken as well,
 > but thats a different story:
 >

This patch enables chrp_pcibios_fixup() for bPlan's machine. however, 
this function should NOT be called as thoses platforms.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=26c5032eaa64090b2a01973b0c6ea9e7f6a80fa7

An upcomming patch will "ppc_md.pcibios_fixup = NULL;" for every bPlan's 
platforms.

Regards,

--------------070801050702090409050507
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------070801050702090409050507--
