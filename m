Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVJRCm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVJRCm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 22:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVJRCm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 22:42:29 -0400
Received: from gherkin.frus.com ([192.158.254.49]:29884 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S932390AbVJRCm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 22:42:28 -0400
Subject: Re: vesafb_blank() vs. Toshiba 730XCDT notebook
In-Reply-To: <43543D4C.3050700@gmail.com> "from Antonino A. Daplas at Oct 18,
 2005 08:09:48 am"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Date: Mon, 17 Oct 2005 21:42:27 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20051018024227.CF151DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Bob Tracy wrote:
> > (Toshiba laptop display problem -- vesafb driver blanking).
> 
> Can you try this patch first? 
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> 
> diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
> --- a/drivers/video/vesafb.c
> +++ b/drivers/video/vesafb.c
> @@ -96,14 +96,14 @@ static int vesafb_blank(int blank, struc
> (...)

That did the trick.  Thanks for the quick turnaround!

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
