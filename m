Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUAaSLm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264566AbUAaSLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:11:42 -0500
Received: from post.tau.ac.il ([132.66.16.11]:1434 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S264278AbUAaSLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:11:40 -0500
Date: Sat, 31 Jan 2004 20:09:32 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Subject: Re: Software Suspend 2.0
Message-ID: <20040131180932.GE11658@luna.mooo.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>
References: <1075436665.2086.3.camel@laptop-linux> <yw1xllnpiwgn.fsf@kth.se> <1075458327.11414.2.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <1075458327.11414.2.camel@laptop-linux>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.53; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I made a patch against 2.6.2-rc2 to fix the rejects which hasn't seemed
to make it to the list yet so I will attach again.
Note that the rejects are easy to fix but there is a problem with
sysctl.c where the #endif belonging to the #ifdef KDB goes way off spot
so the kernel doesn't link.

On Fri, Jan 30, 2004 at 11:25:28PM +1300, Nigel Cunningham wrote:
> Ah. I see. It's not out, but you want bleeding edge :>
> 
> > The patches fail on a 2.6.2-rc2 kernel.  Are there any patches for
> > post-2.6.1 kernels?
> -- 
> My work on Software Suspend is graciously brought to you by
> LinuxFund.org.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--sdtB3X0nJg68CQEu
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="swsusp_fix_2.6.2-rc2.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWea0veMABQZfgEIwe3///3/v376////+YAY/PTb7qaCtBbFAAAQSgNlAAA0A
A9IAAAAAAADhoZNNDTI0NMjIMjI0MgMTRk0AZMjEMcNDJpoaZGhpkZBkZGhkBiaMmgDJkYhh
iQmkm1PU0DTRiGg0GQADQAAAAyaDakVNqZGn6JPKGyjQAGgNABpoADQBoARSEAJhJk0ymVPK
fpR5T9RPUeo0wgep6mgDTE20UySNgYGo3BCh7SZOCJskiAiCIA/kDT6yZKlQzGA3wTJhDCQw
QEDCmr5Q85A4K84Uy+BgKjmQCJUGUh7BEPD0Dio2VfU1CSEDAnWzhCprCRXAW01Gc9RmMt1/
qixs4AgfJ6vCYQXOr4/7knJz5g+n07QSC7ihaPLGwGDoAgdhCkDoMYkz0KACx1Eg8BwDESLo
Pgeo8FjmXgEmAREkkkrNdJJJJKnE0L+ChRbAIYMRNMKUqU5wjYN4cUNsG00cJM9LEmc5lZs0
08TDEbXpypL1FUi1DRSubeJazsbDWGvg2PcVntPZJy11/c3S6HY3tPiJkfNeS/VKtXYyAFQh
kyGQ4QplWzlaUuPOoDOe8c/hNPRLw8PD4qb4pXZnFnYbd4xAwNQO8/8A+YGQGofBjb8lBx1S
Mrb5aTqAcwHD3xj1b4ic6UKUpSg973vHuBvT3Y4bxMAUde23sZgZQL0UkkkkpAA0oiIiPfMO
YUpEUSgctA8QgNgHgjr+ZueuoA4g8gkD7QZg2A0O0Hzg1g0PltJjZA4ShJF3xyBp30AfQYWx
hK8MfKVAN4PMGpNaiyyMfkuBsGL+4ZS0PMtxdkDhUN9KyN1VkN11phBCzncG+tNAHyLkUKlg
lKCWeV10RcTc5KAiBOLdAWUBKmQLInPDxthmbWnLqhRtVmL4Dw9bJCuPqZSO57WIflZL3vET
6BCaH50PERIjd7j2HEolHwF0p0/Qe4u1a9xLxAmcOVR46OB+vcPWEaWv/CTtQPs0kGVm28ft
oPUGkYDt62QYhwz2o0cndKX26g1A3ccLGl2HB+x6s8nRl1Zx7B+4LGdQ2EpBsYvVjSDdKdfC
12N7EpuwBoz/6O+QTY69BmOjK8LmdGQBW1PD7gDoDRiAnla56W5ji41OzrGGbO9oDVbeD1m1
be1AF7lYA9IUqRfkLiVrjSkSMOicsWCiIaakNfQeQYwiJCNU4Z1NM9QpFDrYXBcNpi+AShym
IEp7qpddAk75BVvPhi3uML6mUWyMA+kNSQgaH1+0Zp5RC+BzP6B8xun7LD95iWhw+Pi4MjFl
1/5TMLg9Y7v23hiYB7vWxbgzst90sZxuOQV5m5p7tQtCZ84wNoYmRxAJDmCqEVFVhkNXvuNF
4GXSCSSlMtYuHyEz7EQYOJQDDrse/gQF4cCELQvZBWdrfWSxA5PB8WHQLi0bF2GbATVuE5jx
olSdt1Y/ekyddve10uDmBjKDoWAVy4slPeaym8h8z0sPJSGB7AvwDkdRQxAgenWjo3BZ0qab
6rAnusLm83h+Iog2mnaHbqWhFofVZqG8lpWTrAsCjUHYBSRxdWPI58nqMC7MwAfhv4aeioOB
czG1Kw3ON0g1CYbyiczd2lYcji1/fdg7sy87o/CtznygZE727ADlxMw1BybbYggJQSgrIb1Y
EDsDkEwvDsY4lDbjCWza2qLRvtHWBtDwCg6uLlkUmG0xsYrzZdfT0G9syy84YpkOUSYGMZzD
uOlqOwcybySh5TkFocHECiVA9lEcSoAgPpHEet9PYBcEBcEdsER5dGYYhIN5fG04rDm+arMa
dwF1upTrcu67yDyCsm0qmBNtCRVDAYvQcnbJk7ypkwwwkBuGBJSYa5dx+qFAqSZbIOY4fgHD
OcONuGJA2tdBoGA4UsqajpMHZoED4h507nnu5yDNGYbs3IRqMwzeAblYC7gg3LXxsYgSCP/i
7kinChIc1pe8YA==

--sdtB3X0nJg68CQEu--
