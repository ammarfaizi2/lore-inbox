Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWFOIfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWFOIfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 04:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWFOIfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 04:35:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:64495 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751419AbWFOIfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 04:35:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=nBimiz7b1eq2Wy0rkbFVYxf+5pTYFk37/xHa42Mwlm9+hingvLaPrpvrpHqB8Sc1wTdqZSPKn8xdpmF+7/ox7fLMjtnl9jq72o3Yh/0e8hG5I1uTvr74DnRDVemSeCEYDPGK5X96JJdP2OgPRVvyMmGakVZPeihrb3QBy7XiiYI=
Date: Thu, 15 Jun 2006 10:35:25 +0200
From: Laura Garcia <nevola@gmail.com>
To: "Laura Garcia" <laura.linux@gmail.com>, bjorn.helgaas@hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] CCISS cleanups
Message-ID: <20060615103525.5ebc42c4@enano>
In-Reply-To: <c6b285c60606150114h273f5ceue19bcea43937e86c@mail.gmail.com>
References: <200606141707.27404.bjorn.helgaas@hp.com>
	<c6b285c60606150114h273f5ceue19bcea43937e86c@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

	Reading cciss and cpqarray driver code, I've noticed that both have very similar structure so, could it be useful to merge both drivers in only one?


Best regards.


"Bjorn Helgaas" <bjorn.helgaas@hp.com> wrote:

> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Date: 15-jun-2006 1:07
> Subject: [PATCH 0/7] CCISS cleanups
> To: Mike Miller <mike.miller@hp.com>
> Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org, Andrew Morton
> <akpm@osdl.org>
> 
> 
> This is a series of minor cleanups to the cciss (HP Smart Array) driver:
> 
>   1  disable device before returning failure
>   2  claim all resources the device decodes, not just I/O ports
>   3  print more useful identification when driver claims device
>   4  remove intermediate #define for ARRAY_SIZE
>   5  fix spelling errors
>   6  unparenthesize "return" statements
>   7  Lindent (warning, huge diff, but changes whitespace only)
> 
> They're in order of usefulness.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
