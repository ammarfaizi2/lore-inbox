Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVLBQcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVLBQcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVLBQcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:32:45 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:30192 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750810AbVLBQco convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:32:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AvAPyi01jhxT8fk71833fSi0pyS+r6EukM81NS8yWab9lee++7P1KP8NREUO7Pnrxjo9Mw7JyNFD+cjd20zEz2Irl4FX0nlhPFti8TgOeu+z9kwKVUtDmUQnNbxqBJgWLTSpYL4y+7dR6f5o5aJPe4IXaKovf1JnqTO1+/j9KPk=
Message-ID: <2cd57c900512020832n62a66d1q@mail.gmail.com>
Date: Sat, 3 Dec 2005 00:32:40 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Use enum to declare errno values
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <4390701C.1030803@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <20051123233016.4a6522cf.pj@sgi.com>
	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
	 <200512020849.28475.vda@ilport.com.ua>
	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
	 <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com>
	 <2cd57c900512020456n2f31101k@mail.gmail.com>
	 <4390701C.1030803@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/3, Bill Davidsen <davidsen@tmr.com>:
> Using enum doesn't *solve* problems, it does *allow* type checking, and
> *prevent* namespace pollution. Use of typedef allows future changes, if
> you use "struct XXX" you're stuck with it.

Yes, Greg KH had a lecture at a KS to encourage us to "stuck with it".
And akpm once told me to always use struct foo * when I was trying to
use task_t in argument list and struct task_struct *.for variable
definitions.

What do you mean by `future change'? You constantly change the struct
name or its members? I don't see any real problem hier.

>
> --
> bill davidsen <davidsen@tmr.com>
>    CTO TMR Associates, Inc
>    Doing interesting things with small computers since 1979
>

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
