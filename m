Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWFBSVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWFBSVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWFBSVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:21:42 -0400
Received: from wx-out-0102.google.com ([66.249.82.205]:31216 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751434AbWFBSVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:21:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=mEqnhWgk7WrQ3nEy4t+0Nw1CnUmVeaTDJEU/NuPk9y2zJtXlp1wkn0xnSbdFsuJJVwNfj63683p4eNM064IO3V8RxwaoXrOQbACvWT10kVApdy1Wx7tENnflBNGCHbDB+0Bk8L00QlNNNtDFdluwQtSWGC2R1tWMbPItAcnu+2M=
Message-ID: <986ed62e0606021121t5ba8fd9bo2ce516267b269850@mail.gmail.com>
Date: Fri, 2 Jun 2006 11:21:40 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.17-rc5-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <1149263463.11429.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	 <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
	 <20060601183836.d318950e.akpm@osdl.org>
	 <986ed62e0606020614j363bd71bn7d1fba23b78571f3@mail.gmail.com>
	 <1149263463.11429.2.camel@localhost.localdomain>
X-Google-Sender-Auth: 79ca3f7d35465f5b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-06-02 at 06:14 -0700, Barry K. Nathan wrote:
[snip]
> > Just one problem with that...
> >
> > config ATALK
> >         tristate "Appletalk protocol support"
> >         select LLC
>
> Strange. ATALK doesn't need 802.2LLC, merely SNAP.

There's CONFIG_LLC, and there's also CONFIG_LLC2. I wonder if actual
802.2LLC support is the latter, not the former...
-- 
-Barry K. Nathan <barryn@pobox.com>
