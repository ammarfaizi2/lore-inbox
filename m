Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUIBLAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUIBLAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUIBK5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:57:00 -0400
Received: from users.linvision.com ([62.58.92.114]:23462 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268229AbUIBKye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:54:34 -0400
Date: Thu, 2 Sep 2004 12:54:33 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Romano Giannetti <romano@dea.icai.upco.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Driver retries disk errors.
Message-ID: <20040902105433.GA23881@bitwizard.nl>
References: <20040831135403.GB2854@bitwizard.nl> <1093961570.597.2.camel@localhost.localdomain> <20040831155653.GD17261@harddisk-recovery.com> <1093965233.599.8.camel@localhost.localdomain> <20040831170016.GF17261@harddisk-recovery.com> <1093968767.597.14.camel@localhost.localdomain> <20040901152817.GA4375@pern.dea.icai.upco.es> <1094049877.2787.1.camel@localhost.localdomain> <20040901231434.GD28809@bitwizard.nl> <1094117369.4852.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094117369.4852.15.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 10:29:29AM +0100, Alan Cox wrote:
> On Iau, 2004-09-02 at 00:14, Rogier Wolff wrote:
> > I don't think so. It starts with the ide-cd level driver 
> > doing 8 retries. Most disk we see retry themselves for about  a 
> > 4 second delay before reporting a bad block. A CD taking twice
> 
> "Most", that is the heart of the reason for not taking them out.

Some retry only for about a second, the rest takes more than
4 seconds. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
