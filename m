Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUJKOaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUJKOaT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUJKO3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:29:53 -0400
Received: from CPE-203-51-28-190.nsw.bigpond.net.au ([203.51.28.190]:15600
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S269015AbUJKOXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:23:34 -0400
Message-ID: <416A9763.8070009@eyal.emu.id.au>
Date: Tue, 12 Oct 2004 00:23:31 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1
References: <20041011032502.299dc88d.akpm@osdl.org>
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
 > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/

 > +i2o-code-beautifying-and-cleanup.patch
 > +i2o-added-support-for-promise-controllers.patch
 > +i2o-new-functions-to-convert-messages-to-a-virtual-address.patch
 > +i2o-correct-error-code-if-bus-is-busy-in-i2o_scsi.patch
 > +i2o-message-conversion-fix-for-le32_to_cpu-parameters.patch
 >
 >  i2o driver update

WARNING: /lib/modules/2.6.9-rc4-mm1/kernel/drivers/message/i2o/i2o_scsi.ko needs unknown symbol i2o_msg_in_to_virt
WARNING: /lib/modules/2.6.9-rc4-mm1/kernel/drivers/message/i2o/i2o_core.ko needs unknown symbol i2o_msg_in_to_virt
WARNING: /lib/modules/2.6.9-rc4-mm1/kernel/drivers/message/i2o/i2o_core.ko needs unknown symbol i2o_msg_out_to_virt
WARNING: /lib/modules/2.6.9-rc4-mm1/kernel/drivers/message/i2o/i2o_block.ko needs unknown symbol i2o_msg_in_to_virt

The references were added in -mm3, but the function is missing.

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
