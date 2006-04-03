Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751764AbWDCQQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbWDCQQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWDCQQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:16:10 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:33200 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751764AbWDCQQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:16:09 -0400
Date: Mon, 3 Apr 2006 17:16:04 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix MIPS PFN/page borkage
Message-ID: <20060403161604.GA29351@linux-mips.org>
References: <20060403161131.0790DD9A@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403161131.0790DD9A@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 09:11:31AM -0700, Dave Hansen wrote:

> The "unify PFN_* macros" patch screwed up and somehow modified
> the MIPS code where it shouldn't have.  This backs those changes
> back out.

You need to include <linux/pfn.h> for this to build.

  Ralf
