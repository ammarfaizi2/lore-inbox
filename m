Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267715AbTBGEoA>; Thu, 6 Feb 2003 23:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267714AbTBGEoA>; Thu, 6 Feb 2003 23:44:00 -0500
Received: from beppo.feral.com ([192.67.166.79]:21258 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S267713AbTBGEn5>;
	Thu, 6 Feb 2003 23:43:57 -0500
Date: Thu, 6 Feb 2003 20:53:13 -0800 (PST)
From: Matthew Jacob <mjacob@feral.com>
X-X-Sender: mjacob@beppo
Reply-To: mjacob@feral.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, <patmans@us.ibm.com>, <mbligh@aracnet.com>,
       <James.Bottomley@steeleye.com>, <mikeand@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
In-Reply-To: <20030207043534.GU1599@holomorphy.com>
Message-ID: <20030206205117.F37336-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The other thing to note is that I'm not really very happy with my driver
at present. It may be working well for some people, but *I* think it
needs some rework before it's really ready for primetime again. I need
to split out the SCSI && FC dependencies. I need to move the name server
code out of the main body and make it more policy driven.

The trouble is also that it's just a hobby for me right now (no clients
with direct Linux support requirements) , and as a recent parent I've
had a lot less hobby time.


On Thu, 6 Feb 2003, William Lee Irwin III wrote:

> On Thu, Feb 06, 2003 at 08:19:39PM -0800, Andrew Morton wrote:
> >> http://www.feral.com/isp.html seems to be 2.4.x-only.
>
> On Thu, Feb 06, 2003 at 11:24:40PM -0500, Doug Ledford wrote:
> > As answered elsewhere, the 2.5 port isn't done yet.  That's why I said in
> > my email "if it's ready for 2.5" because I was afraid Matthew hadn't
> > gotten around to doing the 2.5 update yet.  However, if no one else can do
> > it, I can make a 2.5 update of this driver happen (I don't suspect it
> > would be that hard actually, not *that* much has to change).
>
> This driver's bugginess is a _major_ nuisance to me and I don't have
> the SCSI know-how to fix it myself. I'd _love_ to test a driver with a
> prayer of working anytime this century.
>
> Thanks.
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

