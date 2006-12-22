Return-Path: <linux-kernel-owner+w=401wt.eu-S1945946AbWLVFjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945946AbWLVFjF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 00:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945932AbWLVFjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 00:39:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:53609 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945946AbWLVFjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 00:39:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qdPwxqb+G1y43fwnlptM7P8bSyWrI3MKOYGqd7m2nsA9VTxnr9ynioB8VUwURrffh1xUH+TbLMCoKH8y/Oo2o053fqbsjo9E86mxwezGjbJ/XUOD13ZmpPylXPj59JuGGWgnT9+YzIhgzIlXKZ+tA2P6wVtat45dlr6TJrM7knE=
Message-ID: <652016d30612212139l40c6163djf79db8a68b6eb334@mail.gmail.com>
Date: Fri, 22 Dec 2006 11:24:03 +0545
From: "Manish Regmi" <regmi.manish@gmail.com>
To: "Erik Mouw" <mouw@nl.linux.org>
Subject: Re: Linux disk performance.
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061221132241.GA15226@gateway.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>
	 <1166431020.3365.931.camel@laptopd505.fenrus.org>
	 <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com>
	 <4589B92F.2030006@tmr.com>
	 <652016d30612202203h16331f96o2147872db3cb2d43@mail.gmail.com>
	 <20061221132241.GA15226@gateway.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/06, Erik Mouw <mouw@nl.linux.org> wrote:
> Bursty video traffic is really an application that could take advantage
> from the kernel buffering. Unless you want to reinvent the wheel and do
> the buffering yourself (it is possible though, I've done it on IRIX).

But in my test O_DIRECT gave a slight better performance. Also the CPU
usage decreased.

>
> BTW, why are you so keen on smooth-at-the-microlevel writeout? With
> real time video applications it's only important not to drop frames.
> How fast those frames will go to the disk isn't really an issue, as
> long as you don't overflow the intermediate buffer.

Actually i dont require  smooth-at-the-microlevel writeout but the
timing bumps are overflowing the intermediate buffers . I was just
wondering if i could decrease the 20ms bumps to 3 ms as in other
writes.

>
> Erik
>
> --
> They're all fools. Don't worry. Darwin may be slow, but he'll
> eventually get them. -- Matthew Lammers in alt.sysadmin.recovery
>


-- 
---------------------------------------------------------------
regards
Manish Regmi

---------------------------------------------------------------
UNIX without a C Compiler is like eating Spaghetti with your mouth
sewn shut. It just doesn't make sense.
