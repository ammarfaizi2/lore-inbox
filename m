Return-Path: <linux-kernel-owner+w=401wt.eu-S1426021AbWLHRN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426021AbWLHRN0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426032AbWLHRNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:13:25 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:55146 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426021AbWLHRNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:13:24 -0500
Date: Fri, 8 Dec 2006 18:13:23 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Laurent CARON <lcaron@premier.fr>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org
Subject: Re: [Vserver] Kernel panic on a DELL 2850
Message-ID: <20061208171323.GA22241@MAIL.13thfloor.at>
Mail-Followup-To: Laurent CARON <lcaron@premier.fr>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org
References: <45793116.3080503@premier.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45793116.3080503@premier.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 10:32:06AM +0100, Laurent CARON wrote:
> Hi,
> 
> One of our server crashed tonight.
> 
> Since it has been working flawlessy in the past, i'm wondering why.
> 
> Here are the specs
> Dual Xeon
> 8GB Memory
> 2 Software Raid 6 Arrays
> 
> Kernel is 2.6.18 with vserver patch
> 
> If someone could please tell me where the error is likely to come from
> it would be great.
> 
> Hardcopy of the crash is available at: http://zenon.apartia.fr/panic.jpg

looks like a mainline rcu issue, won't hurt to 
update to 2.6.18.5 ...

HTH,
Herbert

> Thanks
> 
> Laurent
> 
> _______________________________________________
> Vserver mailing list
> Vserver@list.linux-vserver.org
> http://list.linux-vserver.org/mailman/listinfo/vserver
