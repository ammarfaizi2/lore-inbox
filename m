Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbRDCGgl>; Tue, 3 Apr 2001 02:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132624AbRDCGgc>; Tue, 3 Apr 2001 02:36:32 -0400
Received: from ANice-101-2-1-104.abo.wanadoo.fr ([193.251.10.104]:2052 "HELO
	leda.udcast.com") by vger.kernel.org with SMTP id <S132619AbRDCGgZ>;
	Tue, 3 Apr 2001 02:36:25 -0400
X-Mailer: XFMail 1.4.7p2 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200103310537.f2V5bDO06729@pcug.org.au>
Date: Tue, 03 Apr 2001 08:35:41 +0200 (CEST)
In-Reply-To: <200103310537.f2V5bDO06729@pcug.org.au>
Message-ID: <yp94rw7tp3o.fsf@leda.udcast.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Xref: leda.udcast.com sent_mail:28
From: "Alain E." <aln03@UDcast.com>
To: Stephen Rothwell <already_sent_by_error@UDcast.com>
Subject: Re: Recent problems with APM and XFree86-4.0.1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Stephen,

I've just switched from 2.2.18 to 2.4.3 (on a Dell Inpiron 8000, r128 M4
adapter) and I am experimenting some problems with Xfree 4.02 (debian woody)
and (probably) APM. When I resume after a suspend, the X server
hangs. Connecting through ethernet, using strace -p `pid-of-Xfree` wake up
the Xserver. Everything is OK if I use kernel 2.2.18.  I've tryed the NoPM
option, but it is ignored by the Xserver:
(WW) R128(0): Option "NoPM" is not used

Any Idea ?


Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Jamie,
> 
> Jamie Lokier <lk@tantalophile.demon.co.uk> writes:
> > 
> > On that theme of power management with X problems, I have been having
> > trouble with my laptop crashing when the lid is closed, instead of
> > suspending as it used to.  The laptop is a Toshiba Satellite 4070CDT.
> 
> Can you please try adding
>       Option  "NoPM"
> to the device section of XF86Config or (XF86Config) and then try suspending
> and resuming.
> 
> This made suspend/resume much more reliable on the Thinkpad 600E with
> XFree86 4.  Also you could try XFree86 4.0.2, as I know that it actually
> does interact with APM (4.0.1 may have as well - I am not sure).
> 
> Cheers,
> Stephen Rothwell              sfr@canb.auug.org.au

-- 
Alain
