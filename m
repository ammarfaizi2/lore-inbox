Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135412AbRATDBC>; Fri, 19 Jan 2001 22:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136066AbRATDAw>; Fri, 19 Jan 2001 22:00:52 -0500
Received: from 2-011.cwb-adsl.brasiltelecom.net.br ([200.193.161.11]:8437 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S135412AbRATDAj>; Fri, 19 Jan 2001 22:00:39 -0500
Date: Fri, 19 Jan 2001 23:14:53 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Billy Harvey <Billy.Harvey@thrillseeker.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: -ac10 compile error
Message-ID: <20010119231453.H1050@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Billy Harvey <Billy.Harvey@thrillseeker.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <14952.64914.247694.762188@rhino.thrillseeker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14952.64914.247694.762188@rhino.thrillseeker.net>; from Billy.Harvey@thrillseeker.net on Fri, Jan 19, 2001 at 09:53:06PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 19, 2001 at 09:53:06PM -0500, Billy Harvey escreveu:
> /usr/src/linux/drivers/sound
> 
> cs46xx.c:4238: banner causes a section type conflict

probably one __initdata is a const char? get rid of the const keyword and
try again. No patch as I've not yet downloaded -ac10

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
