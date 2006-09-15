Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWIOXu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWIOXu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWIOXu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:50:27 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:27553 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932222AbWIOXu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:50:27 -0400
Date: Fri, 15 Sep 2006 18:50:25 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH 0/4]: PowerPC: EEH: Add support for MMIO enabled recovery step
Message-ID: <20060915235025.GQ29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

Please apply and submit upstream. These patches are not urgent, 
and are mostly harmless.

The following set of patches add support for the MMIO-enabled
EEH recovery path, that is, for the path through te PCI error 
recovery code where the device driver claims it can recover 
on its own, and just wants MMIO enabled.  

Actually, the first two patches are misc EEH cleanup, 
the last two implement this function.

--linas

