Return-Path: <linux-kernel-owner+w=401wt.eu-S1161006AbXAEHxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbXAEHxr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbXAEHxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:53:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:39620 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161006AbXAEHxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:53:46 -0500
Subject: [PATCH 4/9] KVM: Add missing 'break'
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:53:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075345.5E740250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1922,6 +1922,7 @@ static long kvm_dev_ioctl(struct file *f
 				 num_msrs_to_save * sizeof(u32)))
 			goto out;
 		r = 0;
+		break;
 	}
 	default:
 		;
