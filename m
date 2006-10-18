Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161259AbWJRSXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161259AbWJRSXk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161256AbWJRSXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:23:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:12640 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161259AbWJRSXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:23:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ghpoULqXJ+xuNvQPcmTQiAsV/2VA9QfxapIne14nu4jT26FzmfkoJENCH1Ek7HW5ELc6+w/taCsI458Ea1pdZdGvY6j6coRyFFanGE9Mw+kAjtreOD/Zyl0tjIIcTI/i0tD1B4ATF3rFZ587yW8WHgyuAhvMPmGF0HFgIaD1fAs=
Message-ID: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com>
Date: Wed, 18 Oct 2006 14:23:37 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       ebiederm@xmission.com
Subject: sysctl
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the wireless-extensions thread, Linus writes:

> In general, the answer to "when can we break user space" is very simple.
>
> Never.
>
> It's just not acceptable. We maintain old interfaces for years (and in
> some cases, well over a decade by now), simply because the pain from not
> doing so is horrendous, and it makes debugging impossible. You get into
> situations where users need to upgrade to tools that don't work with older
> kernels, and can thus not downgrade, etc etc.

I guess the sysctl question has been answered then,
especially since random normal apps use sysctl.

If it needs a maintainer, put me down.

I think the main problem was fixed long ago,
by assigning fixed numbers to the enum values.
Practically no other kernel code uses an enum
for an ABI, and I think we can see why.
