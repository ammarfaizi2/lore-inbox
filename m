Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136244AbRECIpW>; Thu, 3 May 2001 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136247AbRECIpM>; Thu, 3 May 2001 04:45:12 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23242 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S136244AbRECIox>;
	Thu, 3 May 2001 04:44:53 -0400
Message-ID: <3AF11A7E.9184627C@mandrakesoft.com>
Date: Thu, 03 May 2001 04:44:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <3AF10E80.63727970@alsa-project.org> <3AF11211.B226543D@mandrakesoft.com> <3AF11953.54BBE72B@alsa-project.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abramo Bagnara wrote:
> > > That's indeed the reason to change ioremap prototype for 2.5.
> >
> > Say what??
> >
> 
> Please give a look
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0008.1/0338.html
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0008.1/0407.html
> 
> This was something that already got a wide consent.

Let's not return unsigned long -- DaveM's suggestion is far better. 
unsigned long is not opaque enough, IMHO.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
