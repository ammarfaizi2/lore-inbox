Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVBOO4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVBOO4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 09:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVBOO4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 09:56:39 -0500
Received: from 11.ylenurme.ee ([193.40.6.11]:1198 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S261743AbVBOO4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 09:56:33 -0500
Message-ID: <42120009.705@ylenurme.ee>
Date: Tue, 15 Feb 2005 15:58:33 +0200
From: Elmer Joandi <elmer@ylenurme.ee>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI lockup 2.6.10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My laptop, intel Centrino M based, all intel chips except graphics.

After opening laptop, I have to push power button, then it goes:

Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2055
in_atomic():0,irqs_disabled():1
__might_sleep
__kmalloc
acpi_os_allocate
acpi_ut_callocate
acpi_ut_initialize_buffer
acpi_rc_create_byte_stream
acpi_rs_set_srs_method_data
acpi_pci_link_set
irqrouter_resume
sysdev_resume
device_power_up
suspend_enter
enter_state
acpi_suspend
copy_from_user
acpi_system_write_sleep
vfs_write
strncpy_from_user
sys_write
sysenter_past_esp
PM: Finishing up.

and there it is , every day :)




