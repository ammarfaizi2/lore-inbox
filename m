Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVC3EVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVC3EVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 23:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVC3EVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 23:21:06 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:64143 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261537AbVC3EU6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 23:20:58 -0500
In-Reply-To: <84ab51297f043a761321ee6eddc43d4a@embeddededge.com>
References: <84ab51297f043a761321ee6eddc43d4a@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <1c52c0b6db38845c0bd6636e056d4c64@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>, <shall@mvista.com>,
       "Kumar Gala" <galak@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] ppc32: CPM2 PIC cleanup irq_to_siubit array
Date: Tue, 29 Mar 2005 22:20:36 -0600
To: "Dan Malek" <dan@embeddededge.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Done, updated patch w/comment sent to Andrew.

- kumar

On Mar 29, 2005, at 7:10 PM, Dan Malek wrote:

>
>
> On Mar 29, 2005, at 5:30 PM, Kumar Gala wrote:
>
> > Cleaned up irq_to_siubit array so we no longer need to do 1 <<
> > (31-bit),
>  > just 1 << bit.
>
> Will you please put a comment in here that indicates this array now
>  has this computation done?  When I wrote it, these bit numbers
>  matched the registers and the documentation, so I didn't take
> the time to explain. :-)
>
> Thanks.
>
>
>
>         -- Dan

