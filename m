Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318838AbSH1Nyn>; Wed, 28 Aug 2002 09:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318842AbSH1Nyn>; Wed, 28 Aug 2002 09:54:43 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:22774 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318838AbSH1Nyl>; Wed, 28 Aug 2002 09:54:41 -0400
Subject: Re: problems with changing UID/GID
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <871y8jxktd.fsf@Login.CERT.Uni-Stuttgart.DE>
References: <20020826133028.GA21965@cissol7.cis.nctu.edu.tw>
	<1030369551.1750.4.camel@irongate.swansea.linux.org.uk> 
	<871y8jxktd.fsf@Login.CERT.Uni-Stuttgart.DE>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 28 Aug 2002 15:01:40 +0100
Message-Id: <1030543300.7290.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-28 at 12:51, Florian Weimer wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> >> But, the credentials are per-task in Linux, so it's possible to have
> >> two tasks in a process running under different UIDs.
> >
> > Really useful isnt it
> 
> And not supported by GNU libc, neither officially nor by the current
> implementation. :-(

Its supported by clone() and programs using clone directly, not by the
legacy pthreads interface

