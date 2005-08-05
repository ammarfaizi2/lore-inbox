Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVHES3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVHES3P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVHES1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:27:18 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:53317 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261946AbVHES0i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:26:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=meRS9ApN2I7dtooLXTMJgBpzSF9GRbmg5W8+Pbncc8is5MbkIFwCOkMoiLFBZpCJ1TGpcPGBBDomO8xhCjirSrRw6A5NiLiI390NFL/G9cIfVBjrmFfAyCdZW37nSvbjHiC51p1+FxjKSr6ej+mJxVvUTLsNGg57qKqI3XV881E=
Message-ID: <86802c44050805112661d889aa@mail.gmail.com>
Date: Fri, 5 Aug 2005 11:26:38 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: mthca and LinuxBIOS
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <52psss5k1x.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com> <52mznxacbp.fsf@cisco.com>
	 <86802c4405080410236ba59619@mail.gmail.com>
	 <86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
	 <86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
	 <86802c440508051103500f6942@mail.gmail.com>
	 <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

before I do the cg-update this morning, it didn't mask out the upper 8 bit.

YH

On 8/5/05, Roland Dreier <rolandd@cisco.com> wrote:
>     yhlu> ps.  some kernel pci code patch broke sth yesterday night.
>     yhlu> it mask out bit [32-39]
> 
> Is it possible that all your problems are coming from the PCI setup
> code incorrectly assigning BARs?
> 
>  - R.
>
