Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbTBZS7m>; Wed, 26 Feb 2003 13:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268678AbTBZS7m>; Wed, 26 Feb 2003 13:59:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20619
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268675AbTBZS7l>; Wed, 26 Feb 2003 13:59:41 -0500
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: davej@codemonkey.org.uk, schlicht@uni-mannheim.de,
       Linus Torvalds <torvalds@transmeta.com>, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030226104723.76df4b18.akpm@digeo.com>
References: <200302251908.55097.schlicht@uni-mannheim.de>
	 <20030226103742.GA29250@suse.de> <20030226015409.78e8e1fb.akpm@digeo.com>
	 <20030226111905.GA32415@suse.de> <20030226022819.44e1873a.akpm@digeo.com>
	 <1046266771.8948.1.camel@irongate.swansea.linux.org.uk>
	 <20030226104723.76df4b18.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046290303.9837.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 26 Feb 2003 20:11:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 18:47, Andrew Morton wrote:
> If that resend results in delivery of an actual extra interrupt, the
> resent-to CPU can start playing with stuff which used to be on the sender's
> stack and the box goes splat.
> 
> Didn't sct have a fix for that?

Yes but it was never merged mainstream for some reason. I think it kind of
got away

