Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVHIFI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVHIFI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbVHIFI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:08:29 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:17539 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750744AbVHIFI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:08:29 -0400
Date: Tue, 9 Aug 2005 01:08:27 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: serue@us.ibm.com
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [PATCH] seclvl: use securityfs
In-Reply-To: <20050809004321.GA9332@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.63.0508090107190.20178@excalibur.intercode>
References: <20050809004321.GA9332@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, serue@us.ibm.com wrote:

This looks like a nice cleanup.

> +
> +	if (count < 0 || count >= PAGE_SIZE)
> +		return -ENOMEM;
> +	if (*ppos != 0) {
> +		return -EINVAL;
> +	}

Why is the first error there -ENOMEM and not -EINVAL?


- James
-- 
James Morris
<jmorris@namei.org>
