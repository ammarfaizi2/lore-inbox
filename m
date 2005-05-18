Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVERJiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVERJiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVERJiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:38:22 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:51591 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S262139AbVERJiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:38:21 -0400
To: Erik Slagter <erik@slagter.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: computer freezes / harddisk led stays on after S3 resume
In-Reply-To: <1116408408.3505.26.camel@localhost.localdomain>
References: <1116408408.3505.26.camel@localhost.localdomain>
Date: Wed, 18 May 2005 10:38:20 +0100
Message-Id: <E1DYL0O-0006Cf-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter <erik@slagter.name> wrote:
> 1. computer freezes / harddisk led stays on after S3 resume

Linux doesn't currently implement the IDE resume part of the ACPI spec,
which probably has something to do with this.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
