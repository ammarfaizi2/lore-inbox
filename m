Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWBDUb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWBDUb3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 15:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWBDUb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 15:31:29 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:59018 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932564AbWBDUb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 15:31:29 -0500
Subject: Re: [RFC PATCH] crc generation fix for EXPORT_SYMBOL_GPL
From: Arjan van de Ven <arjan@infradead.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060202041543.GA6755@RAM>
References: <20060202041543.GA6755@RAM>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 21:31:26 +0100
Message-Id: <1139085087.3131.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 20:15 -0800, Ram Pai wrote:
> Currently genksym does not take into account the GPLness of the exported
> symbol while generating the crc for the exported symbol. Any symbol
> changes from EXPORT_SYMBOL to EXPORT_SYMBOL_GPL would not reflect in the
> Module.symvers file.  This patch fixes that problem.

and this is a problem.. why?


