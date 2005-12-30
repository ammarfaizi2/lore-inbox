Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbVL3Thj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVL3Thj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVL3Thj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:37:39 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:19429 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751300AbVL3Thj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:37:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SLbZCmtUMLudMlwfzgsztXIYMb/lIvg31HsPqfQQIrIzqjrrVO3nHAE8rsK5GdM9CJp8CoR7ZCRf5pMuJps2UPz6+Ywt3PRe5cpsY1gvM7ieSwgTvOi1GqU3iH0cx2GKbBdDdoxo5Xc2+9cXY51I/qBKP+Bt18BPPXySrJHqJEU=
Message-ID: <986ed62e0512301137o3ee36bf1yadac63784cb75dd3@mail.gmail.com>
Date: Fri, 30 Dec 2005 11:37:38 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, alan@redhat.com
In-Reply-To: <20051230183308.GA2501@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051230074401.GA7501@ip68-225-251-162.oc.oc.cox.net>
	 <20051230174817.GW15993@alpha.home.local>
	 <1135966666.2941.32.camel@laptopd505.fenrus.org>
	 <20051230183308.GA2501@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/05, Willy Tarreau <willy@w.ods.org> wrote:
> On Fri, Dec 30, 2005 at 07:17:46PM +0100, Arjan van de Ven wrote:
[snip discussion not directly related to the timing of my patch submission]
> > Also I think, to be honest, that this is a feature that is getting
> > unsuitable for the "bugfixes only" 2.4 kernel series....
>
> Agreed, it really is too late IMHO, because there's a non-null risk of
> introducing new bugs with it. It would have been cool a few months
> earlier. That won't stop me from trying it in my own tree however ;-)

Yeah, I know it's a little bit late. I wish I had been able to get
this done a few months ago... :(

Oh well, even if it doesn't get into the tree, at least it looks like
I might not be the only person to benefit from this patch. :) (BTW,
you'll probably also want the patch I just posted, which adds
Committed_AS to /proc/meminfo.)

--
-Barry K. Nathan <barryn@pobox.com>
