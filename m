Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUKSLtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUKSLtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKSLrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:47:52 -0500
Received: from smtp.loomes.de ([212.40.161.2]:188 "EHLO falcon.loomes.de")
	by vger.kernel.org with ESMTP id S261361AbUKSLqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:46:33 -0500
Subject: Re: [patch] 2.6.10-rc1-mm4: bttv-driver.c compile error
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
In-Reply-To: <20041118165853.GA22216@bytesex>
References: <20041109074909.3f287966.akpm@osdl.org>
	 <1100018489.7011.4.camel@lb.loomes.de> <20041109211107.GB5892@stusta.de>
	 <1100037358.1519.6.camel@lb.loomes.de> <20041110082407.GA23090@bytesex>
	 <1100085569.1591.6.camel@lb.loomes.de>  <20041118165853.GA22216@bytesex>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 19 Nov 2004 12:46:06 +0100
Message-Id: <1100864766.5359.5.camel@lb.loomes.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 17:58 +0100, Gerd Knorr wrote:
> > kobject_register failed forBA¤ÿÿÿÿ (-17)
> 
> Yet another kobject bug.  It uses the varargs list twice in a illegal
> way.  That doesn't harm on i386 by pure luck, but blows things up on
> amd64 machines.  The patch below fixes it.

Thank you Gerd!
IMHO the patch should be applied to both mm- and the Linus tree.

___ 
Markus

