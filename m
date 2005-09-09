Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbVIIIvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbVIIIvW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVIIIu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:50:56 -0400
Received: from mail.suse.de ([195.135.220.2]:23438 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965097AbVIIIuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:50:54 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [discuss] [PATCH] x86-64 CFI annotation fixes and additions
Date: Fri, 9 Sep 2005 10:50:48 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <43207A6302000078000244F4@emea1-mh.id2.novell.com> <200509091040.11405.ak@suse.de> <4321688A020000780002481E@emea1-mh.id2.novell.com>
In-Reply-To: <4321688A020000780002481E@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509091050.49112.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 10:48, Jan Beulich wrote:
> >The UNWIND_INFO part has still some problems - in particular it is
>
> lying
>
> >on all other architectures which don't check it yet. I made it
>
> dependent
>
> >on X86_64 right now.
>
> I don't think so. First, the i386 patch also adds the same (as I
> indicated), and second this controls also the
> -fasynchronous-exception-tables compiler flag, which should be
> generically available on all architectures (the i386 patch adds this to
> the top level makefile, x86-64 is somewhat special in requiring the
> -fno- form to be used in the opposite case, which is why this ends up in
> the arch-specific makefile).

Well then I cannot apply it if the i386 patch doesn't go in first.

I will remove these parts for now.

-Andi

