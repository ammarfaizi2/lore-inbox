Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbWHOT0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWHOT0m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWHOT0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:26:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:59968 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965238AbWHOT0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:26:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m6sCRfktEJqkaOpw98jWKixn/9dSRrx+7/RdKw4S6MYxsPopNMBVB7k3YSspD9TtNguiKLd3qTu7Wb1uQUc5eEgv3s+urdSlJ7ZWlo3uePmTLRlnWeYJGoERxArJj78sXFGP8FeGxd5VimSc8gNGsZhLt4hef/BDcOJ0FlNfmLw=
Message-ID: <3420082f0608151226h32dc20c1oe0b20549922c8f7@mail.gmail.com>
Date: Wed, 16 Aug 2006 00:26:32 +0500
From: "Irfan Habib" <irfan.habib@gmail.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Maximum number of processes in Linux
In-Reply-To: <1155669584.3011.178.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3420082f0608151059s40373a0bg4a1af3618c2b1a05@mail.gmail.com>
	 <Pine.LNX.4.61.0608151419120.13947@chaos.analogic.com>
	 <20060815182219.GL8776@1wt.eu>
	 <Pine.LNX.4.61.0608151511310.3138@chaos.analogic.com>
	 <1155669584.3011.178.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 1GB RAM and a p4 HT 3 GHz.


On 8/16/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > Shows a consistent 6140.
> >
>
> the default limit in proc scales with memory (to avoid really bad
> stuff), you can oversize it to 2^16 if you want.
>
> Going over 2^16 is not too good an idea (16 bit counters overflow),
> especially if you have hostile users (read: students) on the machine,
> since this is the kind of scenario you can trigger on purpose.
>
>
>
