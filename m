Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318165AbSGQAWx>; Tue, 16 Jul 2002 20:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSGQAWw>; Tue, 16 Jul 2002 20:22:52 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27636 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318165AbSGQAWw>; Tue, 16 Jul 2002 20:22:52 -0400
Subject: Re: close return value
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: zack@codesourcery.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020716.165241.123987278.davem@redhat.com>
References: <20020716232225.GH358@codesourcery.com>
	<1026867782.1688.108.camel@irongate.swansea.linux.org.uk> 
	<20020716.165241.123987278.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 02:35:41 +0100
Message-Id: <1026869741.2119.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 00:52, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 17 Jul 2002 02:03:02 +0100
>    
>    close() checking is not about physical disk guarantees. It's about more
>    basic "I/O completed". In some future Linux only close() might tell you
>    about some kinds of I/O error. The fact it doesn't do it now is no
>    excuse for sloppy programming
> 
> Practice dictates that if you make close() return error values
> your whole system will blow up.  Try it out for yourself.
> I can tell you of at least 1 app that is going to explode :-)
> 
> I believe Linus mentioned way back when that this is a "shall not"
> when we had similar problems with NFS returning errors from close().

Our NFS can return errors from close(). So I'd get fixing the
applications.

