Return-Path: <linux-kernel-owner+w=401wt.eu-S932817AbWL0Ndz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932817AbWL0Ndz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 08:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932820AbWL0Ndz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 08:33:55 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:12619 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbWL0Ndy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 08:33:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q530fToBgff7Tsq9jCyvKM88ac9mJOpuCJfQvnyoOSEXcN6A617Xgjae9w5m2udn2E/e01BgmVTNVfUzW3LpNH1R5AthknvLCeOw2sBFmdTSkb8ntw0H0GxmGab9DSe1/SqZu44FkM4LOiJVCOAzjK07BSkz8t5eJtIByW5dpCc=
Message-ID: <b3f268590612270533t63bf6632x3e324c1f2365b5eb@mail.gmail.com>
Date: Wed, 27 Dec 2006 22:33:53 +0900
From: "Jari Sundell" <sundell.software@gmail.com>
To: "valdyn@gmail.com" <valdyn@gmail.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Cc: linux-kernel@vger.kernel.org, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Andrei Popa" <andrei.popa@i-neo.ro>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>,
       "Andrew Morton" <akpm@osdl.org>,
       "Gordon Farquharson" <gordonfarquharson@gmail.com>,
       "Martin Michlmayr" <tbm@cyrius.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <20061227124423.GA8520@master.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	 <1166962478.7442.0.camel@localhost>
	 <20061224043102.d152e5b4.akpm@osdl.org>
	 <1166978752.7022.1.camel@localhost>
	 <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org>
	 <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
	 <4590F9E5.4060300@yahoo.com.au>
	 <Pine.LNX.4.64.0612261007100.3671@woody.osdl.org>
	 <20061227124423.GA8520@master.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/06, valdyn@gmail.com <valdyn@gmail.com> wrote:
> I do get this error on reiserfs ( old one, didn't try on reiser4 ).
> Stock 2.6.19 plus reiser4 patch. Previously reported by me only in the
> debian bts.

I've had reports of corrupted data on earlier kernel releases with
reiserfs3, which were fixed by upgrading to reiserfs4.

Jari Sundell
