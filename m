Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVAVSIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVAVSIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 13:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAVSIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 13:08:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24594 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262611AbVAVRrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:47:22 -0500
Date: Sat, 22 Jan 2005 17:47:18 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: I2C algorithm IDs
Message-ID: <20050122174718.A27993@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Are I2C algorithm IDs supposed to be unique?  Do they have any meaning in
reality at all?  If the answer is yes to either of these questions, the
following should probably be resolved:

#define I2C_ALGO_PCA    0x150000        /* PCA 9564 style adapters      */
#define I2C_ALGO_SIBYTE 0x150000        /* Broadcom SiByte SOCs         */

-- 
Russell King

