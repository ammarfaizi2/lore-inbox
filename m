Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUGFSop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUGFSop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUGFSop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:44:45 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:3771 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S264260AbUGFSoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:44:44 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Redeeman <lkml@metanurb.dk>
Subject: Re: quite big breakthrough in the BAD network performance, which mm6 did not fix
Date: Tue, 6 Jul 2004 11:46:06 -0700
User-Agent: KMail/1.6.82
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
References: <1089070720.14870.6.camel@localhost> <20040706135303.GG20237@harddisk-recovery.com> <1089128977.10626.11.camel@localhost>
In-Reply-To: <1089128977.10626.11.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407061146.07703.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, this isn't that sufficient enough in proving your case. Like I said 
before, please provide benchmarks from an http ( apache ) server on your 
private network to validate theese claims. 

Matt H.

On Tuesday 06 July 2004 8:49 am, Redeeman wrote:
> On Tue, 2004-07-06 at 15:53 +0200, Erik Mouw wrote:
> > On Tue, Jul 06, 2004 at 03:25:30PM +0200, Redeeman wrote:
> > > i am aware of this, however, what i use to benchmark is kernel.org, as
> > > i can see they have alot bandwith free.
> > > if i use kernel.org http i get 50kb/s, if i use ftp, i can easily fetch
> > > with 200kb/s
> >
> > That could be easily explained by the fact that the www.kernel.org ftp
> > and http services are handled by different programs (vsftpd vs.
> > Apache).
>
> yeah it could.. however it isnt. because 2.6.5 can easily take 200kb/s
> from kernel.org http, and it sound strange too, that with 2.6.7 ALL http
> adresses only give 50kb/s, and with 2.6.5 it gives 200 :>
>
> > Erik
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
