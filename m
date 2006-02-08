Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbWBHXUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbWBHXUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030534AbWBHXUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:20:06 -0500
Received: from mail.fuw.edu.pl ([193.0.80.14]:698 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030529AbWBHXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:20:05 -0500
From: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Organization: FUW
To: 7eggert@gmx.de
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 9 Feb 2006 00:20:59 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@suspend2.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <5BoER-4GL-3@gated-at.bofh.it> <E1F6pHz-0000kU-FN@be1.lrz> <200602081523.15002.rjw@sisk.pl>
In-Reply-To: <200602081523.15002.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602090021.00262.Rafal.Wysocki@fuw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 February 2006 15:23, Rafael J. Wysocki wrote:
> On Wednesday 08 February 2006 14:23, Bodo Eggert wrote:
> > There are some questions I have while looking at this HOWTO,
> > which I think should be answered there:
> > 
> > Pavel Machek <pavel@ucw.cz> wrote:
> > 
> > > Suspend-to-disk HOWTO
> > > ~~~~~~~~~~~~~~~~~~~~
> > [...]
> > > ./suspend /dev/<your_swap_partition>
> > 
> > Does it need to be mounted (so it possibly gets filled and thereby unusable),
> > or can it be a mkswapped partition?
> 
> A mkswapped one will do.

Sorry, that's not true.  For now the tools only work with mounted swap
partitions, but they use the kernel to allocate free swap pages from them.

Greetings,
Rafael
