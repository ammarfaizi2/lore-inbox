Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVEMTQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVEMTQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVEMTPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:15:03 -0400
Received: from colin.muc.de ([193.149.48.1]:19718 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262490AbVEMTF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:05:57 -0400
Date: 13 May 2005 21:05:49 +0200
Date: Fri, 13 May 2005 21:05:49 +0200
From: Andi Kleen <ak@muc.de>
To: "Richard F. Rebel" <rrebel@whenu.com>
Cc: Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513190549.GB47131@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116009483.4689.803.camel@rebel.corp.whenu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 02:38:03PM -0400, Richard F. Rebel wrote:
> On Fri, 2005-05-13 at 20:03 +0200, Andi Kleen wrote:
> > This is not a kernel problem, but a user space problem. The fix 
> > is to change the user space crypto code to need the same number of cache line
> > accesses on all keys. 
> > 
> > Disabling HT for this would the totally wrong approach, like throwing
> > out the baby with the bath water.
> > 
> > -Andi
> 
> Why?  It's certainly reasonable to disable it for the time being and
> even prudent to do so.

No, i strongly disagree on that. The reasonable thing to do is
to fix the crypto code which has this vulnerability, not break
a useful performance enhancement for everybody else.

-Andi
