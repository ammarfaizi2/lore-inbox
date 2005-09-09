Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVIIH6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVIIH6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVIIH6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:58:54 -0400
Received: from ns.suse.de ([195.135.220.2]:55939 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751439AbVIIH6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:58:53 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR II
Date: Fri, 9 Sep 2005 09:58:48 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com> <20050909071407.GI19913@wotan.suse.de> <43215C9B02000078000247E4@emea1-mh.id2.novell.com>
In-Reply-To: <43215C9B02000078000247E4@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509090958.48907.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 September 2005 09:57, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 09.09.05 09:14:07 >>>
> >>
> >> ??? This is what the code doing the setup does. But the question was
>
> -
>
> >> what do you need the IDT entry for?
> >
> >Without an IDT entry you cannot receive it?
>
> But that's the point - if it's delivered as an NMI, it'll arrive
> through vector 2 (the vector information specified is ignored).

Good point. I wonder how this ever worked. I'll remove it.

-Andi
