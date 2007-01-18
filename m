Return-Path: <linux-kernel-owner+w=401wt.eu-S1751844AbXARKLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbXARKLA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbXARKLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:11:00 -0500
Received: from web7706.mail.in.yahoo.com ([202.86.4.44]:31403 "HELO
	web7706.mail.in.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751762AbXARKK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:10:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=kFkxeafsGL8YfjALyoBJwUKGf0STt38DGPOnylXEPK/+sq8h7arLgMqurbgcAIeMtSOsmH4cZ3vVTc6+mUmsnFQ7eVvwAS4sm+B+Nl8vGfEdcFxCfhca0DkGX2dxhBu6GPyaxQS/H+D4Yx6mJ7+QiwDZy8Bd2mNON1/6w9cweRE=;
X-YMail-OSG: 0xxosgQVM1kEmu3mNhfKOYE8M7nHvZ5hm5h1cQzhaJecl9gwgGEwZ0spo3PaYuQJOlTYw52jW1SbQflSMvnK75OjNGz2mNUH9SoA7d5rpsoY4BFji4wSxYu6A_5ZS2vY
Date: Thu, 18 Jan 2007 10:10:56 +0000 (GMT)
From: Seetharam Dharmosoth <seetharam_kernel@yahoo.co.in>
Subject: Re: query related to serial console
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org
In-Reply-To: <20070118090935.GA32068@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <288311.57722.qm@web7706.mail.in.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Thu, Jan 18, 2007 at 05:39:15AM +0000, Seetharam
> Dharmosoth wrote:
> > I have one doubt in this regard.
> > 1) once we connected to the serial console we
> don't
> >    want to login into the shell.
> >    (without login into the shell we want to fire
> the
> >    sysrq command like b, r m, etc.)
> > 
> >  for this I am doing like 
> >   grabing the serial console then
> >   doing ctrl+]
> >   so that getting 
> >               telnet> 
> > now i want to give command like b, m ,r etc.
> > 
> > but it is not accepting my commands until I do 
> > telnet> send brk
> > 
> > can you please explain me why like this behavior ?
> 
> If it didn't require a break before hand, merely
> pressing 'b', 'm' or 'r'
> would trigger the sysrq command, which would make it
> absolutely impossible
> to login or type any normal command containing those
> characters.
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   -
> http://www.arm.linux.org.uk/
>  maintainer of:
> 
Thanks.

I am not able to find the code path for 
'send brk'

can you please let me know what would be the code path
when we do 'send brk' in linux.

I am interested about 8250 and uart serial driver.

currently using kernel 2.6.7.

Thanks
Seetharam


		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/
