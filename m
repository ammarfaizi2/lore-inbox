Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUIBKbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUIBKbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268147AbUIBKbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:31:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:43405 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268145AbUIBKbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:31:39 -0400
Subject: Re: Driver retries disk errors.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Romano Giannetti <romano@dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040901231434.GD28809@bitwizard.nl>
References: <20040830163931.GA4295@bitwizard.nl>
	 <1093952715.32684.12.camel@localhost.localdomain>
	 <20040831135403.GB2854@bitwizard.nl>
	 <1093961570.597.2.camel@localhost.localdomain>
	 <20040831155653.GD17261@harddisk-recovery.com>
	 <1093965233.599.8.camel@localhost.localdomain>
	 <20040831170016.GF17261@harddisk-recovery.com>
	 <1093968767.597.14.camel@localhost.localdomain>
	 <20040901152817.GA4375@pern.dea.icai.upco.es>
	 <1094049877.2787.1.camel@localhost.localdomain>
	 <20040901231434.GD28809@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094117369.4852.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 10:29:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 00:14, Rogier Wolff wrote:
> I don't think so. It starts with the ide-cd level driver 
> doing 8 retries. Most disk we see retry themselves for about  a 
> 4 second delay before reporting a bad block. A CD taking twice

"Most", that is the heart of the reason for not taking them out.

> that much would not sound abnormal. (seeks are about 10 times
> as expensive on CDs). 8 times 8 seconds is a full minute. 

As I said media players need a way to turn it to no retry

