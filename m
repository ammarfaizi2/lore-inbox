Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVAFN6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVAFN6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVAFN6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:58:18 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:26381 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262826AbVAFN6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:58:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nyKsf+jtRqnqckhS76Cl+aMz3OapztSGjoUT9gAsbf4mNaZKrBsbvK6GHg9iaLgcdvtdr25pERzOHv21QI3dY/M8LpQTd0TT/7ivpG4oPIhbXJ1wBVtez/pmzi+FCCigsZrGJYmOPyA9ahDN2AFIt/dPvQ/iOZtYikhVOXUuNDw=
Message-ID: <58cb370e05010605584cdcd400@mail.gmail.com>
Date: Thu, 6 Jan 2005 14:58:07 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-os@analogic.com
Subject: Re: 2.6.10: "[permanent]" modules?
Cc: Christoph Hellwig <hch@infradead.org>, Harald Dunkel <harald@coware.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501060744330.17811@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41DCE48E.5010604@coware.com>
	 <20050106092858.GB15162@infradead.org>
	 <Pine.LNX.4.61.0501060744330.17811@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005 07:46:53 -0500 (EST), linux-os
<linux-os@chaos.analogic.com> wrote:
> On Thu, 6 Jan 2005, Christoph Hellwig wrote:
> 
> > On Thu, Jan 06, 2005 at 08:11:10AM +0100, Harald Dunkel wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Hi folks,
> >>
> >> Seems that for 2.6.10 I cannot unload ide modules.
> >> 'lsmod | grep permanent" lists
> >
> > ...
> >
> >> Is this on purpose?
> >
> > Yes.
> >
> 
> Can you explain? Normally if a module is no longer in use, it
> can be unloaded. I'm sure that there are number of folks
> who would like to know how come it's now necessary to reboot
> to get rid of some module no longer in use.

It can be unloaded given that the needed locking
and cleanup code are in place...
