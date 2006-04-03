Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWDCQlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWDCQlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDCQlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:41:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:64962 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750856AbWDCQlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:41:46 -0400
Subject: [PATCH 0/7] tpm: TPM 1.2 support
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:42:20 -0500
Message-Id: <1144082540.29910.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch set contains numerous changes to the base tpm
driver 
(tpm.c) to support the next generation of TPM chips.  The changes
include new sysfs files because of more relevant data being available, a
function to access the timeout and duration values for the chip, and
changes to make use of those duration values.  Duration in the TPM
specification is defined as the maximum amount of time the chip could
take to return the results.  Commands are in one of three categories
short, medium and long.  Also included are cleanups of how the commands
for the sysfs files are composed to reduce a bunch of redundant arrays.

Kylie

