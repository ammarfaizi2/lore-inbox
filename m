Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWBHOWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWBHOWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 09:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWBHOWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 09:22:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:42173 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030358AbWBHOWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 09:22:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: 7eggert@gmx.de
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 15:23:14 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <5BoER-4GL-3@gated-at.bofh.it> <5DKUI-1Dm-21@gated-at.bofh.it> <E1F6pHz-0000kU-FN@be1.lrz>
In-Reply-To: <E1F6pHz-0000kU-FN@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081523.15002.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 February 2006 14:23, Bodo Eggert wrote:
> There are some questions I have while looking at this HOWTO,
> which I think should be answered there:
> 
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Suspend-to-disk HOWTO
> > ~~~~~~~~~~~~~~~~~~~~
> [...]
> > ./suspend /dev/<your_swap_partition>
> 
> Does it need to be mounted (so it possibly gets filled and thereby unusable),
> or can it be a mkswapped partition?

A mkswapped one will do.  Actually a mounted one will do either and the data
on it won't get damaged.

> Can it even be a swap-file?

No.

> Probably not, unless you want to resume by ro-nojournalreplay-mounting the
> corresponding partition. 
> 
> How big does it have to be, compared to the RAM? As big + n? Bigger? BIGGER?

May be smaller.  You'll need at most 1/2 of your RAM size of free space on it.

I'll put the answers in the howto, thanks for the hint.

Greetings,
Rafael
