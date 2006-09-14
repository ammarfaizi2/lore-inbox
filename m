Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWINXyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWINXyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWINXyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:54:45 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:2436 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932151AbWINXyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:54:45 -0400
Date: Thu, 14 Sep 2006 19:47:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: ACPI Exception (acpi_thermal-0412)
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>
Message-ID: <200609141951_MC3-1-CB3C-3653@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this message at boot on 2.6.18-rc6:

 ACPI Exception (acpi_thermal-0412): AE_NOT_FOUND, Invalid active threshold [0] [20060707]

Followed by:

 ACPI: Thermal Zone [THRM] (47 C)

And looking in /proc/acpi/thermal_zone/THRM/cooling_mode, I see:

<setting not supported>
cooling mode:   passive

The fan seems to run at low speed even when CPU temp is stable at 37C,
and speeds up when it gets warmer, so there seems to be no overheating
problem (highest temp seen under full load is 60C.)

Is this normal?

-- 
Chuck
