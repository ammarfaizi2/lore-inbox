Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVGQDLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVGQDLd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 23:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVGQDLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 23:11:30 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38330 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261731AbVGQDL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 23:11:28 -0400
Subject: Re: [2.6 patch] SCSI_QLA2ABC mustn't select SCSI_FC_ATTRS
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James.Bottomley@SteelEye.com
In-Reply-To: <20050717023809.GE3613@stusta.de>
References: <20050715013653.36006990.akpm@osdl.org>
	 <20050715102744.GA3569@stusta.de> <20050715144037.GA25648@plap.qlogic.org>
	 <20050717023809.GE3613@stusta.de>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 23:11:26 -0400
Message-Id: <1121569886.13990.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 04:38 +0200, Adrian Bunk wrote:
> SCSI_QLA2XXX is automatically enabled for (SCSI && PCI).

This has bugged me for a while.  Why does this one SCSI driver default
to Y in the first place?

Lee

