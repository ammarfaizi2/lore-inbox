Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVFAMNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVFAMNK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVFAMNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:13:10 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:25264 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261354AbVFAMNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:13:07 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] Sample fix for hyperthread exploit
Date: Wed, 1 Jun 2005 22:13:24 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
References: <200506012158.39805.kernel@kolivas.org> <1117627597.6271.29.camel@laptopd505.fenrus.org>
In-Reply-To: <1117627597.6271.29.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506012213.25445.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005 22:06, Arjan van de Ven wrote:
> > Comments?
>
> I don't think it's really worth it, but if you go this way I'd rather do
> this via a prctl() so that apps can tell the kernel "I'd like to run
> exclusive on a core". That'd be much better than blindly isolating all
> applications.

I agree, and this is where we (could) implement the core isolation. I'm still 
under the impression (as you appear to be) that this theoretical exploit is 
not worth trying to work around.

Cheers,
Con
