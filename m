Return-Path: <linux-kernel-owner+w=401wt.eu-S1750696AbXAIAHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAIAHN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1749667AbXAIAHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:07:12 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56256 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbXAIAHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:07:11 -0500
Date: Mon, 8 Jan 2007 16:06:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: <Andries.Brouwer@cwi.nl>
Cc: danarag@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minix V3 support
Message-Id: <20070108160653.865ee345.akpm@osdl.org>
In-Reply-To: <200701081807.l08I7iN03348@apps.cwi.nl>
References: <200701081807.l08I7iN03348@apps.cwi.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2007 19:07:44 +0100 (MET)
<Andries.Brouwer@cwi.nl> wrote:

> This morning I needed to read a Minix V3 filesystem,
> but unfortunately my 2.6.19 did not support that,
> and neither did the downloaded 2.6.20rc4.
> 
> Fortunately, google told me that Daniel Aragones had
> already done the work, patch found at
> http://www.terra.es/personal2/danarag/
> 
> Unfortunaly, looking at the patch was painful to my eyes,
> so I polished it a bit before applying. The resulting
> kernel boots, and reads the filesystem it needed to read.
> 
> (So, I do not guarantee the patch below, it is almost untested,
> writing is entirely untested, but it certainly contains fewer
> bugs than the patch found at the url above.
> The patch is relative to 2.6.20rc4.)

Looks relatively harmless ;)

Daniel, it'd be good if you could review and test these changes please.

Also, a signed-off-by from yourself and from Andries, please...
