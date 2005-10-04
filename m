Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVJDEzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVJDEzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 00:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVJDEzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 00:55:05 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:13641 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751183AbVJDEzE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 00:55:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eApyR1z8CkKXYJusBlq68wHsX95jX1EQR5RFmvIEgfoUjt5RfAgUEtUDXsXhPMAIIyv0Ojq63D2+pD0J2YqUw2n8oC6zop4VrwXxfM50jv5UHUoP2iBHQfgSti382gYKrtr1VNjmya20xbAEcIYYI4Zc3NHmOtUgHvl+qT9oSq4=
Message-ID: <aec7e5c30510032155y3a66d637k47e728512e4fe762@mail.gmail.com>
Date: Tue, 4 Oct 2005 13:55:03 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCHv2] Document from line in patch format
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, coywolf@gmail.com, greg@kroah.com
In-Reply-To: <20051003203826.514ea047.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002163244.17502.15351.sendpatchset@jackhammer.engr.sgi.com>
	 <Pine.LNX.4.64.0510021158260.31407@g5.osdl.org>
	 <aec7e5c30510032024t6d48643fma875c917acb69d92@mail.gmail.com>
	 <20051003203826.514ea047.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Paul Jackson <pj@sgi.com> wrote:
> Magnus wrote:
> > Huh, I thought that the first line in a unified patch started with
> > "---",
>
> Yes, it does.  But then the next character is a space, and there
> is at least one more space-separated field on the line.

Nitpicking, but with "diff -L" only one space exists, and that is
between "---" and the label. So it is possible to create patches
without time stamp information.

> > Relying on "diff -" or "Index: " seems wrong.
>
> I don't think anyone is relying on those patterns.

Good. Thanks.

/ magnus
