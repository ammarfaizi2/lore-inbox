Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbTBTVcL>; Thu, 20 Feb 2003 16:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTBTVcL>; Thu, 20 Feb 2003 16:32:11 -0500
Received: from fmr01.intel.com ([192.55.52.18]:29639 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266876AbTBTVcL>;
	Thu, 20 Feb 2003 16:32:11 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84713809E@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: pazke@orbita1.ru
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: visws smp detection
Date: Thu, 20 Feb 2003 13:41:13 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding the new code in arch/i386/mach-visws/mpparse.c,

Shouldn't the code that is in find_smp_config() really go in
get_smp_config? I would think all find_smp_config would do would be set
smp_found_config to 1.

Was there a reason for this, or is this just how you got it working?

Thanks -- Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

