Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272568AbRIFUfr>; Thu, 6 Sep 2001 16:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272562AbRIFUfi>; Thu, 6 Sep 2001 16:35:38 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:1549 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272563AbRIFUfV>; Thu, 6 Sep 2001 16:35:21 -0400
Date: Thu, 6 Sep 2001 22:11:52 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wietse Venema <wietse@porcupine.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
Message-ID: <20010906221152.F13547@emma1.emma.line.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wietse Venema <wietse@porcupine.org>,
	Andrey Savochkin <saw@saw.sw.com.sg>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010906172316.E0B74BC06C@spike.porcupine.org> <E15f4ul-0000J5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E15f4ul-0000J5-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001, Alan Cox wrote:

> If you accept 10.0.0.1 from the outside you are leaking information. It

No, if you accept 10.*.*.* from the outside, your routers are broken.

> user configured data isnt a solution. For the 99.9% of normal cases 
> SIOCGIFCONF is going to give the right data. People doing clever things
> will have to set up config files. simple easy - hard possible.

Alan, SIOCGIFCONF is working sufficiently, it's SIOCGIFNETMASK that
we're talking about. SIOCGIFNETMASK works properly on any other system
or - as far as I can currently test - with my patch.

-- 
Matthias Andree
Outlook (Express) users: press Ctrl+F3 for the full source code of this post.
begin  dont_click_this_virus.exe
end
