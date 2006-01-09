Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWAITiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWAITiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWAITiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:38:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:62339 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751238AbWAITiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:38:07 -0500
From: Andi Kleen <ak@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Date: Mon, 9 Jan 2006 20:37:42 +0100
User-Agent: KMail/1.8.2
Cc: "keith" <kmannth@us.ibm.com>, "Matt Tolentino" <metolent@cs.vt.edu>,
       akpm@osdl.org, discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CF@ssvlexmb2.amd.com>
In-Reply-To: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CF@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092037.42840.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 20:28, Lu, Yinghai wrote:
> I don't know, even yes, according to BKDG, you still need to update
> related Routing Table in NB.

I don't really want any memory controller or HT routing 
touching code in the kernel. It would be far too fragile. 
Pushing that work over to firmware using ACPI seems like
the right thing to do.

-Andi
