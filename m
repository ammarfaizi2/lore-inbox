Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVJJNNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVJJNNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVJJNNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:13:38 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:65128 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750777AbVJJNNh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:13:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/jwn4SdNQhP0Fe4+Q6FwhtZN2v7Bb0r+yDH0adG95PWvxjCNQppsGPia4WMjARoxM8NGzuICqUVNSrAwE6xfzfqikvQKfF3NQGvEFMCSHQkA/wjEFeJItaCpcV2xS3Ds1y6vfnDgh1Rbr8cDNQ7EpN94z3CYA5xjj6FREybigY=
Message-ID: <b9a245c10510100613m442d93f4gbbec00799dc3b1b9@mail.gmail.com>
Date: Mon, 10 Oct 2005 18:43:36 +0530
From: Vivek Kutal <vivek.kutal@gmail.com>
To: Fawad Lateef <fawadlateef@gmail.com>
Subject: Re: Need for SHIFT and MASK
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1e62d1370510091721m530327a9v546da9115a861bdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com>
	 <200510091423.24660.ioe-lkml@rameria.de>
	 <b9a245c10510091140q78c2480dqb095a7cdab12932e@mail.gmail.com>
	 <1e62d1370510091721m530327a9v546da9115a861bdf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And as far as SHIFT, MASK, SIZE macros are concerned they are used in
> creating Page Translation Tables and also used to get the translation
> from linear to physical

how are these macros used to create page translation tables (functions
like pgd_alloc(), pmd_alloc() & pte_alloc() are used for this
purpose)and the  translation (virtual/linear to physical)is done by
the processor and not by the OS.


--
Thanks and Regards
Vivek Kutal
http://vivekkutal.blogspot.com

         "Live as if you were to die tomorrow. Learn as if you were to
live forever."
