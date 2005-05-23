Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVEWVg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVEWVg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEWVg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:36:58 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:6118 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261975AbVEWVgz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:36:55 -0400
Date: Mon, 23 May 2005 17:36:55 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Valdis.Kletnieks@vt.edu, James Morris <jmorris@redhat.com>,
       Toml@us.ibm.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Emilyr@us.ibm.com, Kylene@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and
 Readme
Message-ID: <Pine.WNT.4.63.0505231657140.2372@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote on 05/23/2005 04:39:29 PM:

> 
> Actually, you "could" also cat /proc files, then verify the signature
> by hand (using pen and paper :-).

Theoretically, yes. The signature is 2048bit and to validate the signed 
aggregate requires recursively applying SHA1 over all measurements.

> It seems to me that the mechanism is sound... it does what the docs
> says. Another questions is "is it usefull"?
> 
>                         Pavel 
> 

We implemented some exemplary IMA-applications. If you like, visit our 
project page and check out the references:
http://www.research.ibm.com/secure_systems_department/projects/tcglinux/
There you also find a complete  measurement list and a response of a measured 
system replying to an authorized remote measurement-list-request.

Thanks
Reiner


