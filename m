Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbVJ0Flo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbVJ0Flo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 01:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVJ0Flo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 01:41:44 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4843 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964969AbVJ0Fln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 01:41:43 -0400
Subject: CONFIG_X86_INTEL_USERCOPY and MCYRIXIII?
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 01:34:14 -0400
Message-Id: <1130391254.19492.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried it on my EPIA board and it works.  Is there a good reason it's
not allowed by Kconfig?

config X86_INTEL_USERCOPY
        bool
        depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII
|| M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON
        default y

Lee

