Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWF3IOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWF3IOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 04:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWF3IOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 04:14:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:13274 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751469AbWF3IOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 04:14:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=GfpfcEm08pO1Oa2+foMc3Ys5HMxU/gqD4gSI1dMbFKvNDq3KDNmsFfzzMbunpqWimWc8yTUAQIYKx6SrlUEQBfSTroNYsH+Pwlz0cRXVbbX2/WeQp76BresCStUBpVGd85y9WcHr4PLPQyh3SmQPNqbwC8FOd6i/hCa8zmIBaoc=
Date: Fri, 30 Jun 2006 10:14:28 +0200
From: Paolo Ornati <ornati@gmail.com>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Paolo Ornati <ornati@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-v2] Documentation: remove duplicated words
Message-ID: <20060630101428.25f92377@localhost>
In-Reply-To: <20060629132203.A6460@mail.kroptech.com>
References: <20060629164128.5ba9d264@localhost>
	<20060629132203.A6460@mail.kroptech.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 13:22:03 -0400
Adam Kropelin <akropel1@rochester.rr.com> wrote:

> > Remove every (hopefully) duplicated word under Documentation/ and do
> > other small cleanups.
> > 
> > Examples:
> > 	"and and" --> "and"
> > 	"in in" --> "in"
> > 	...
> 
> When the duplicatation was due to a typo, removing the duplicate is the
> not the correct fix. Additionally, there are cases where the text
> actually reads better (or no worse) with the duplication in place.

Ok, thanks a lot.

I've redone the whole thing and I'll send an updated patch with ONLY
changes I'm sure about (=trivial).

I've intentionally left out things I'm not sure about to fix as much as
possible without breaking anything (and to avoid others to re-read the
long patch every time).

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
