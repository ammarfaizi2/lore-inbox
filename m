Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbVCVLoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbVCVLoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVCVLoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:44:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:21975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262386AbVCVLoZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:44:25 -0500
Date: Tue, 22 Mar 2005 03:43:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S2R gone with 2.6.12-rc1-mm1
Message-Id: <20050322034332.4e1814d1.akpm@osdl.org>
In-Reply-To: <20050322110610.GB1940@gamma.logic.tuwien.ac.at>
References: <20050321210411.GB29072@gamma.logic.tuwien.ac.at>
	<20050321132106.3cb48d38.akpm@osdl.org>
	<20050322110610.GB1940@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Preining <preining@logic.at> wrote:
>
> On Mon, 21 Mär 2005, Andrew Morton wrote:
> > > Sorry to bother you again, but I found that S2R does not work anymore
> > > with 2.6.12-rc1-mm1, while it works with the exact same software setup
> > > with 2.6.11-mm4.
> > 
> > Oh.  suspend-to-RAM.
> > 
> > Would this be an ACPI regression?
> 
> Sorry for the S2R. I guess that it is related to the new ACPI stuff
> introduced in bk-acpi lately. What would you suggest:

Well if you could test 2.6.12-rc1 plus rc1-mm1's bk-apci.patch, that would
confirm your theory.

Apart from that - please raise a bugzilla entry for the acpi guys.

