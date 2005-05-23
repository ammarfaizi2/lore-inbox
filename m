Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVEXADQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVEXADQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVEXACb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:02:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54239 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261228AbVEWX7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:59:17 -0400
Date: Mon, 23 May 2005 19:59:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Reiner Sailer <sailer@us.ibm.com>
cc: Pavel Machek <pavel@ucw.cz>, <Valdis.Kletnieks@vt.edu>, <Toml@us.ibm.com>,
       <linux-security-module@wirex.com>, <linux-kernel@vger.kernel.org>,
       <Emilyr@us.ibm.com>, <Kylene@us.ibm.com>
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
In-Reply-To: <Pine.WNT.4.63.0505231657140.2372@laptop>
Message-ID: <Xine.LNX.4.44.0505231938340.890-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005, Reiner Sailer wrote:

> > It seems to me that the mechanism is sound... it does what the docs
> > says. Another questions is "is it usefull"?
> > 
> >                         Pavel 
> > 
> 
> We implemented some exemplary IMA-applications. If you like, visit our 
> project page and check out the references:
> http://www.research.ibm.com/secure_systems_department/projects/tcglinux/
> There you also find a complete  measurement list and a response of a measured 
> system replying to an authorized remote measurement-list-request.

How did you retrieve the TPM-aggregate?

I'm still not sure why exporting just the kernel measurement values via 
proc is useful.

Wouldn't you need to retrieve the measurement list atomically with the 
TPM-aggregate?

In which case, we'd need an interface which takes a nonce and returns the
kernel measurement list and the TPM-aggregate together.

Is the source of your example IMA attestation application available?


- James
-- 
James Morris
<jmorris@redhat.com>



