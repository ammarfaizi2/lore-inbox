Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVJ1O1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVJ1O1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVJ1O1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:27:10 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:12068 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030190AbVJ1O1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:27:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=P9OYZEvhkGbSpkcc7wlf6QwRTHVdm0gq4yc3M6ajnT466X/tK80/vLE8SGplCYiVs1cOHsMPDNdsQWnUDYkMCD3XDme6vnpuiSnpBCnzAhka3QnVkrLhjqU4su164LH8l+bthx2SutjQNYMJHtEXMHuXtOEyhA9vv6Z1sCBQUJc=
Date: Fri, 28 Oct 2005 18:39:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.14-kj1
Message-ID: <20051028143950.GA27655@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14-kj1 patchset is out. You can get it from
http://coderock.org/kj/2.6.14-kj1/

New in this release
-------------------
-hexdigits_definition_consolidation.patch
+hex_digits_consolidation.patch

	New version of hex digits consolidation from Masoud Sharbiani.
	Is	+EXPORT_SYMBOL(small_digits);
		+EXPORT_SYMBOL(large_digits);	OK?

+drivers_atm_firestream_c_convert_interruptible_sleep_on.patch
+drivers_atm_nicstar_c_replace_interruptible_sleep_on_timeout.patch
+drivers_block_swim3_c_replace_interruptible_sleep_on.patch
+drivers_block_swim_iop_c_replace_interruptible_sleep_on.patch
+drivers_char_amiserial_c_replace_interruptible_sleep_on.patch
+drivers_char_cyclades_c_replace_interruptible_sleep_on.patch
+drivers_char_epca_c_replace_interruptible_sleep_on.patch
+drivers_char_esp_c_replace_interruptible_sleep_on.patch
+drivers_char_generic_serial_c_replace_interruptible_sleep_on.patch
+drivers_char_isicom_c_replace_interruptible_sleep_on.patch
+drivers_char_istallion_c_replace_interruptible_sleep_on.patch
+drivers_char_moxa_c_replace_interruptible_sleep_on.patch
+drivers_char_pcmcia_synclink_cs_c_replace_interruptible_sleep_on.patch
+drivers_char_riscom8_c_replace_interruptible_sleep_on.patch
+drivers_char_rocket_c_replace_interruptible_sleep_on.patch
+drivers_char_serial167_c_replace_interruptible_sleep_on.patch
+drivers_char_specialix_c_replace_interruptible_sleep_on.patch
+drivers_char_stallion_c_replace_interruptible_sleep_on.patch
+drivers_char_synclink_c_replace_interruptible_sleep_on.patch
+drivers_char_synclinkmp_c_replace_interruptible_sleep_on.patch
+drivers_isdn_i4l_isdn_tty_c_replace_interruptible_sleep_on.patch
+drivers_media_radio_radio_cadet_c_replace_interruptible_sleep_on.patch

	Irwan Djajadi continues Nishanth Aravamudan's quest of getting
	rid of *sleep_on* functions. Needs review, review, review...

