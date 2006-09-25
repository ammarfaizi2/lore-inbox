Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWIYTjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWIYTjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 15:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWIYTjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 15:39:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50382 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750753AbWIYTjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 15:39:13 -0400
Message-ID: <4518305C.3090906@pobox.com>
Date: Mon, 25 Sep 2006 15:39:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Henne <henne@nachtwindheim.de>
CC: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata-piix: kerneldoc-error-on-ata_piixc.patch 2nd try
References: <451826BE.2040201@nachtwindheim.de>
In-Reply-To: <451826BE.2040201@nachtwindheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henne wrote:
> Heres a new version of the kerneldoc error in ata_piix.c
> The old one which doesn't apply clean is in 2.6.18-mm1 and can be removed there if acked.
> 
> Greets,
> Henne
> 
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Fixes an error in kerneldoc of ata_piix.c.
> This is the 2nd try, written for 2.6.18-git4
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Several problems with your patch format:

1) your subject line includes-a-bunch-of-words-separated-by-dashes, 
which is incorrect.  Just use standard English.

2) "2nd try" should be inside the brackets ("[", "]"), so that the 
script removes it during merge

3) All comments such as the first paragraph and "Greets, Henne" should 
be moved underneath the "---" separator, so that they are not copied 
into the kernel changelog verbatim.  You force people to hand-edit your 
email before merging.

4) No need for "From:" in the email body, it duplicates the email's 
RFC822 From header.

5) Another comment "This is the 2nd try, written for 2.6.18-git4" which 
should be moved after the "---" separator.  Otherwise, it must be 
hand-edited out.


