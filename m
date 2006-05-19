Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWESDik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWESDik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 23:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWESDik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 23:38:40 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64243 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932208AbWESDik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 23:38:40 -0400
Date: Thu, 18 May 2006 23:38:38 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]   Compile warning in arch/i386/kernel/setup.c
To: linux-kernel@vger.kernel.org
Message-id: <446D3DBE.40607@videotron.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Thunderbird 1.5 (X11/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I got an "implicit function declaration" warning because check_acpi_pci() depends on CONFIG_ACPI, NOT on CONFIG_X86_IO_APIC.

    The following patch fixes this warning and applies to kernel 2.6.16.16.

Regards,

Stephane.
