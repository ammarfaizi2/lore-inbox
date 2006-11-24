Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757688AbWKXLS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688AbWKXLS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 06:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757690AbWKXLS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 06:18:58 -0500
Received: from nz-out-0102.google.com ([64.233.162.193]:52694 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757688AbWKXLS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 06:18:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/VQNMWw4ceK27MTp+mN0mGgtvPiWBL1UyGA1UNc4izxG2ZoU/UDc4lUOWUmUszUw5F94ASMdmO/0s8Y2NNDa60l03C8DIV4wXSc7bQFSuo22qVE+Q7NVXtyz5SFvldJeMwmFt04F6JNWJpk218D+J22VHOn8Vmgo7qncixDH4k=
Message-ID: <9a8748490611240318y3669562fj7ed64350172ea04b@mail.gmail.com>
Date: Fri, 24 Nov 2006 12:18:56 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "d binderman" <dcb314@hotmail.com>
Subject: Re: kernel/power/disk.c(41): remark #593: variable "error" was set but never used
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY107-F9805F8D4EBF632DB1172B9CE10@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY107-F9805F8D4EBF632DB1172B9CE10@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/06, d binderman <dcb314@hotmail.com> wrote:
>
> Hello there,
>
> I just tried to compile Linux kernel 2.6.18.3 with the Intel C
> C compiler.
>
> The compiler said
>
> 1.
>
> kernel/power/disk.c(41): remark #593: variable "error" was set but never
> used
>
> The source code is
>
>     int error = 0;
>
> 2.
>
> kernel/power/disk.c(165): remark #593: variable "error" was set but never
> used
>
> The source code is
>
>     int error;
>
> I have checked the source code and I agree with the compiler.
> Suggest delete local variables.
>

I suggest you send a patch :-)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
