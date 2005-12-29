Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVL2MOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVL2MOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 07:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVL2MOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 07:14:09 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:26200 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750702AbVL2MOI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 07:14:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IEB3BPkKmyv7hkjcp6LIzFhK0RktkrJ2e7wMjJpLwuaZlLb7PP9M3e7UM57l+u3l/3SBIbdyn+zy4gqpj43FW2/BaX8HPqsimNNQ84xvQMDvIsO7hoki5a+B6a7J95QeDkTiNw4EwannbhKhZng57xBGFcBW2xCE+7ZUy25WumQ=
Message-ID: <71a0d6ff0512290414i3e8cc67bi633b8b76fe56336a@mail.gmail.com>
Date: Thu, 29 Dec 2005 15:14:07 +0300
From: Alexander Shishckin <alexander.shishckin@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Redefinition error while compiling LKM
Cc: "pretorious ." <pretorious_i@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1135856947.2935.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <BAY23-F27F5FACE353137AF8C88F8F7290@phx.gbl>
	 <1135856947.2935.17.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/05, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 2005-12-29 at 16:51 +0530, pretorious . wrote:
> > >
> > >and.. why on earth would you need sys/syscall.h ?? (or sys/stat.h for
> > >that matter)
> > >
> > >
> >
> > Trying to override certain syscalls (mknod ...)
>
> eeppp why??
> really don't do that!
>
> (overriding syscalls from modules really shouldn't be done.. there's a
> reason the syscall table isn't exported!)

Perhaps during the 2.4.21 old days sys_call_table was still exported
and there were plenty of 'How to intrecept a syscall in 10 minutes'
documents in the wild.

--
I am free of all prejudices. I hate every one equally.
