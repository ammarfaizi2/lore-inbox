Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVINMuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVINMuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVINMuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 08:50:22 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:1408 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965156AbVINMuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 08:50:21 -0400
Date: Wed, 14 Sep 2005 06:50:14 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Ingo Molnar <mingo@elte.hu>, Alexey Dobriyan <adobriyan@gmail.com>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, seb@highlab.com
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050914125014.GA16698@parisc-linux.org>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru> <20050913185759.GA17272@mars.ravnborg.org> <20050913203720.GA12868@mipter.zuzino.mipt.ru> <20050914074248.GA21436@colo.lackof.org> <20050914074309.GA14116@elte.hu> <20050914091722.GA27148@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914091722.GA27148@colo.lackof.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 03:17:22AM -0600, Grant Grundler wrote:
> Looks like parisc/kernel/drivers.c is out of sync with the
> parisc-linux.org CVS tree. The p-l.o tree doesn't define "next_dev()"
> in drivers.c. It might be obvious to willy what's up here.
> ISTR he wanted to sync up tomorrow with linus again anyway.
> Willy?

The parisc tree hasn't been merged with Linus in a long time because I
find git completely impossible to use.  The howtos are all out of date
and contradict each other.  They don't tell me what I need to know.
Everybody who uses them has their own collection of private scripts that
work around the worst misfeatures.  It's a complete fucking disaster.

The Debian cogito package doesn't have half the tools mentioned in the
howtos, as well as being months out of date.  Last time I had the energy
to fight with it, it didn't even support pack files.

I'd love to stop using CVS and just use git.  But it simply doesn't work.
