Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUCOVoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUCOVoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:44:21 -0500
Received: from mail.tpgi.com.au ([203.12.160.59]:34960 "EHLO mail3.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262762AbUCOVoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:44:17 -0500
Subject: Re: Remove pmdisk from kernel
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20040315132146.24f935c2.akpm@osdl.org>
References: <20040315195440.GA1312@elf.ucw.cz>
	 <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz>
	 <20040315132146.24f935c2.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1079379519.5350.20.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 16 Mar 2004 08:38:39 +1300
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of those changes are hooks to make the freezer for more reliable.
That part of the functionality could be isolated from the bulk of
suspend2. Would that make you happy?

Nigel

On Tue, 2004-03-16 at 10:21, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > > It would be unfortunate if Pat had more development planned or even
> > > underway.  Have we checked?
> > 
> > Last time I attempted pmdisk removal, he did not react. Lets try one
> > more time.
> 
> OK.  Best use his current email address..
> 
> > I believe that you don't want swsusp2 in 2.6. It has hooks all over
> > the place:
> > ...
> > 109 files changed, 3254 insertions(+), 624 deletions(-)
> 
> Ahem.  Agreed.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

