Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVG3ANh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVG3ANh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVG3ALY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:11:24 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:63330 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262827AbVG3AKd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:10:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E3+fypm4fmXEnUF5WTFTOv8/kvcokmOUFrxO4GRmXEHogYWPEz00GcvKyEXffSU+gWptPYQHGeYm0bkG9FuaFa0yer6i032wtOhKBVPb3ArKAEo/153v6dTsyXOATEA59v155BJh4TVukrjLt7oYpB/LL5wr4Y4RP8NtkQslEto=
Message-ID: <4ae3c140507291710489dd9a@mail.gmail.com>
Date: Fri, 29 Jul 2005 20:10:32 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: bert hubert <bert.hubert@netherlabs.nl>, Xin Zhao <uszhaoxin@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why dump_stack results different so much?
In-Reply-To: <20050729212221.GA32570@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140507291327143a9d83@mail.gmail.com>
	 <20050729203403.GA30603@outpost.ds9a.nl>
	 <4ae3c140507291400230ca65c@mail.gmail.com>
	 <20050729212221.GA32570@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I will try. The only problem I have right now is I am using
Xenolinux instead of standard Linux kernel, I cannot see the option to
enable the frame pointer.  But I will figure out how to enable that.

Again, thank you for your help!

Xin


an 7/29/05, bert hubert <bert.hubert@netherlabs.nl> wrote:
> On Fri, Jul 29, 2005 at 05:00:20PM -0400, Xin Zhao wrote:
> > Thanks for your reply.
> >
> > Below is the code that print the kernel calling trace:
> 
> Can I suggest just turning on frame pointers like I suggested?
> 
>  If you say Y here the resulting kernel image will be slightly larger
>  and slower, but it will give very useful debugging information.
>  If you don't debug the kernel, you can say N, but we may not be able
>  to solve problems without frame pointers.
> 
> Good luck!
> 
> --
> http://www.PowerDNS.com      Open source, database driven DNS Software
> http://netherlabs.nl              Open and Closed source services
>
