Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWHNQXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWHNQXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWHNQXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:23:42 -0400
Received: from hera.kernel.org ([140.211.167.34]:20897 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751490AbWHNQXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:23:41 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: HT not active
Date: Mon, 14 Aug 2006 12:19:32 -0400
User-Agent: KMail/1.8.2
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9327.1155557425@ocs10w.ocs.com.au>
In-Reply-To: <9327.1155557425@ocs10w.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141219.33205.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 08:10, Keith Owens wrote:

> You could also need CONFIG_ACPI, I have
> seen HT systems which required ACPI before Linux could see the extra
> threads.

CONFIG_ACPI=y This is required of all HT systems -- except the odd-bird that enables the
siblings in MPS (usually via BIOS settings) in order to trick out some operating systems.

dmesg for the system will tell us if ACPI sees the siblings or not.

-Len
