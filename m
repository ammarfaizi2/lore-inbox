Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbULAFbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbULAFbi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 00:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbULAFbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 00:31:38 -0500
Received: from ems.hclinsys.com ([203.90.70.242]:64527 "EHLO ems.hclinsys.com")
	by vger.kernel.org with ESMTP id S261189AbULAFbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 00:31:37 -0500
Subject: Query regarding current macro
From: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1101879238.7423.13.camel@myLinux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 01 Dec 2004 11:03:58 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I was going through the explanation of the current macro, and found out
that it was got by masking 13-bits LSB the esp register. So is it that
always the process descriptor will start at a location with the last 13
bits are 0??

	I have read that both the kernel stack and process descriptor of a
process is stored in together in an 8KB page. Now the offsets in the
page should start from all bits 0, rite? So then why masking only the 13
bits LSB?? What is the significance of keeping that length at 13??

Please do help!!

TIA
-- 
With regards,

Jagadeesh Bhaskar P

