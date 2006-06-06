Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWFFN3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWFFN3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWFFN3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:29:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:50856 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932150AbWFFN3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:29:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=LFylhLCwOI3VJ+E7yfB9JSI72BOAfGqjoO+GSRgkb2A0j52RVX9yyzAn9vtH2Fod572RNYEY6LbgirpXxGATLkMRazCBxqG6WJq0YHWVWpn9olIGMyZCGVbghx9fRr1Grzz6AtPBTDymWz/xh2P51IIX5eXagSF6Pa/XESXdx1I=
Date: Tue, 6 Jun 2006 15:29:07 +0200
From: Diego Calleja <diegocg@gmail.com>
To: be-news06@lina.inka.de (Bernd Eckenfels)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Update sysctl documentation
Message-Id: <20060606152907.1eccaefb.diegocg@gmail.com>
In-Reply-To: <E1FnSEw-0005MC-00@calista.eckenfels.net>
References: <20060606035833.bee909af.diegocg@gmail.com>
	<E1FnSEw-0005MC-00@calista.eckenfels.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 06 Jun 2006 05:28:22 +0200,
be-news06@lina.inka.de (Bernd Eckenfels) escribió:

> In the net case for example ipv4/conf/* is such a usefull cluster,
> especially since there is this dynamic all/default/<iface> functionality.

Well, all the subdirectories under ipv4/conf/* have the same set of 
files. The differences between each directory is documented in
ipv4/conf/README

> And I also think you should not create TODO single-line files, better

I'd rather get some feedback and document all of them, to be fair, i'll
look into the source to guess what are they doing.

> BTW: perhaps some markup would be nice so we can create the man pages out of
> it? One thing I am impressed with in the BSD world is the existence of
> up-to-date Kernel ABI man pages.

Well, it'd be nice, but I'm afraid that it wouldn't be easy :) To
start with, we'd also need to document everything under sysfs....
