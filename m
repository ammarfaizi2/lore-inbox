Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVKWUeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVKWUeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVKWUdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:33:01 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:39219 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932389AbVKWUcp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:32:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CyvtMUTJVetp9Ug83YU3QTmu4eiY+RXYn9T2lughWGnMmN/BzvI7gdpXxINTlo8zQOwOUTiiKrbHZtDa1B9WwmHL9m/8SSg8gPf91pbnx0q4n/V+VwYa3wY1pRHD9tBPFCUDsMkF+Jpmx4rRoArGObuGQQuHa0+oXcBR2TYYZoE=
Message-ID: <9a8748490511231232y2112475bwb19aa73dfa38d916@mail.gmail.com>
Date: Wed, 23 Nov 2005 21:32:44 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Subject: Re: 2.6.14 kswapd eating too much CPU
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051123202438.GE28142@fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051122125959.GR16080@fi.muni.cz>
	 <20051122163550.160e4395.akpm@osdl.org>
	 <20051123010122.GA7573@fi.muni.cz> <4383D1CC.4050407@yahoo.com.au>
	 <20051123051358.GB7573@fi.muni.cz> <20051123131417.GH24091@fi.muni.cz>
	 <20051123110241.528a0b37.akpm@osdl.org>
	 <20051123202438.GE28142@fi.muni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Jan Kasprzak <kas@fi.muni.cz> wrote:
> Andrew Morton wrote:
> : Jan Kasprzak <kas@fi.muni.cz> wrote:
> : >
> : >     I am at 2.6.15-rc2 now, the problem is still there.
> : >  Currently according to top(1), kswapd1 eats >98% CPU for 50 minutes now
> : >  and counting.
> :
> : When it's doing this, could you do sysrq-p a few times?  The output of that
> : should tell us where the CPU is executing.
>
>         Hmm, it does not show anything but the header. Should I enable
> something special in the kernel?
>

CONFIG_MAGIC_SYSRQ=y
(it's in 'Kernel hacking')


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
