Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWCYQuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWCYQuX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 11:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWCYQuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 11:50:23 -0500
Received: from cantor.suse.de ([195.135.220.2]:18656 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750885AbWCYQuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 11:50:22 -0500
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 1 of 4] Rename e820_map to e820_any_map to reflect its behavior better
Date: Sat, 25 Mar 2006 17:50:10 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <1143303796.2898.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1143303796.2898.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251750.10444.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 March 2006 17:23, Arjan van de Ven wrote:
> Rename e820_mapped to e820_any_mapped since it tests if any part
> of the range is mapped according to the type. Later steps will introduce
> e820_all_mapped which will check if the entire range is mapped with the type.
> Both have their merit.

I merged it after fixing it all up. There were rejects. Merged the i386
changes with the x86-64 changes. And removed the bogus hunk in the MCFG
patch. Also some cosmetic changes to make the lines < 80 chars 

Thanks,

-Andi
