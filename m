Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSLQAqV>; Mon, 16 Dec 2002 19:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLQAqV>; Mon, 16 Dec 2002 19:46:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41696
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262877AbSLQAqU>; Mon, 16 Dec 2002 19:46:20 -0500
Subject: Re: Linux 2.2.24-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pawel Kot <pkot@linuxnews.pl>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212170113350.14563-100000@urtica.linuxnews.pl>
References: <Pine.LNX.4.33.0212170113350.14563-100000@urtica.linuxnews.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 01:33:53 +0000
Message-Id: <1040088833.13837.115.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 00:15, Pawel Kot wrote:
>                 case X86_VENDOR_AMD:
> -                       init_amd(c);
> +                       if(init_amd(c))
> +                               return;
>                         return;
> 
>                 case X86_VENDOR_CENTAUR:
> What does it fix?

If we get a vendor string, we should use it - thats all

