Return-Path: <linux-kernel-owner+w=401wt.eu-S1753427AbWLYBVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbWLYBVY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 20:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbWLYBVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 20:21:24 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:56381 "EHLO
	smtpq2.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbWLYBVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 20:21:23 -0500
X-Greylist: delayed 1608 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 20:21:23 EST
Message-ID: <458F20FB.7040900@gmail.com>
Date: Mon, 25 Dec 2006 01:53:15 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>
In-Reply-To: <458EEDF7.4000200@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:

> Use adding __init to romsignature() (it's only called from probe_roms() 
> which is itself __init) as an excuse to submit a pedantic cleanup.

Hmm, by the way, if romsignature() needs this probe_kernel_address() 
thing, why doesn't romchecksum()?

(Rusty in CC as author of bd472c794bbf6771c3fc1c58f188bc16c393d2fe)

Rene.
