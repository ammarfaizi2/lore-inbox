Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUFCPzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUFCPzF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbUFCPyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:54:46 -0400
Received: from CS2075.cs.fsu.edu ([128.186.122.75]:37149 "EHLO mail.cs.fsu.edu")
	by vger.kernel.org with ESMTP id S264836AbUFCPxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:53:37 -0400
Message-ID: <1086278015.07e5e9ff7c143@system.cs.fsu.edu>
Date: Thu,  3 Jun 2004 11:53:35 -0400
From: khandelw@cs.fsu.edu
To: Mike Jagdis <mjagdis@eris-associates.co.uk>
Cc: jyotiraditya@softhome.net, linux-kernel@vger.kernel.org
Subject: Re: Select/Poll
References: <courier.40BD66BD.00006D7D@softhome.net>
	<1086190109.a0ea5ca71914e@system.cs.fsu.edu>
	<20040603151058.GA3169@eris-associates.co.uk>
In-Reply-To: <20040603151058.GA3169@eris-associates.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 12.151.80.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I meant it in the context of TCP. I thought it was implicit enough, because if
he was using UDP then packet loss is expected. (not necessary that it will
happen)

- Amit Khandelwal

 Quoting Mike Jagdis <mjagdis@eris-associates.co.uk>:

> On Wed, Jun 02, 2004 at 11:28:29AM -0400, khandelw@cs.fsu.edu wrote:
> > Hello,
> >    Can you give more details - Like which machine which vendor etc.,
> > On a sony vaio pcg frv31 laptop/ redhat 9.0/ after firing some 36,000+
> request
> > my select multiplexed server used to fail. With select I believe you not
> get
> > any packet loss...
>
> Then you'd be wrong. Poll/select tell you when desriptors
> are readable/writable. They do *not* impose any magic queuing
> mechanism that guarantees the buffers won't overflow. If the
> low level protocol is non-flow controlled like UDP you *have*
> to read data faster than it arrives and not write data faster
> than it is being transmitted.
>
> Mike
>
> --
> Mike Jagdis                        Web: http://www.eris-associates.co.uk
> Eris Associates Limited            Tel: +44 7780 608 368
> Reading, England                   Fax: +44 118 926 6974
>


