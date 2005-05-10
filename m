Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVEJKpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVEJKpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 06:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEJKpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 06:45:02 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:19781 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261602AbVEJKoe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 06:44:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EDSFcUHVZ/nrrsZhrE4FTd5Eseohplr9qmIDvALmE2jHP5aJPYUlySqmyawFAl+m6w8GAcOemAFgbtxueyvuUiYk0+VlG+lwIpvrwh2/jDlUwBx/9NrmLyCRwBBhC6SayjCHu94i8gDJBV3ssUzZvHdrxmcsSry25zj2nC2wLeM=
Message-ID: <2cd57c900505100344365e5bbc@mail.gmail.com>
Date: Tue, 10 May 2005 18:44:34 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Raj Inguva <inguva@gmail.com>
Subject: Re: Crashing red hat linux
Cc: dipankar das <dipankar_dd@yahoo.com>, akt-announce@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1115719421.1436.1.camel@ringuva.blr.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050510082629.29225.qmail@web40704.mail.yahoo.com>
	 <1115719421.1436.1.camel@ringuva.blr.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Raj Inguva <inguva@gmail.com> wrote:
> >  Does Red hat like Monta vista allow crashing the
> > kernel by writing to  "/dev/crash" if not whats the
> > easiest way ?
> >
> 
> I used to insmod a driver which calls panic() during module
> initialization. I used to do this for testing lkcd.


Now we have crashdump shipped with kexec.

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
