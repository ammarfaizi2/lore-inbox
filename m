Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUGaU07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUGaU07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUGaU07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 16:26:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39339 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261951AbUGaU05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 16:26:57 -0400
Date: Sat, 31 Jul 2004 16:25:57 -0400
From: Alan Cox <alan@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ben Greear <greearb@candelatech.com>, Willy Tarreau <willy@w.ods.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       alan@redhat.com, jgarzik@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-ID: <20040731202557.GA20472@devserv.devel.redhat.com>
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org> <410BD0E3.2090302@candelatech.com> <20040731170551.GA27559@alpha.home.local> <410BD525.3010102@candelatech.com> <1091304989.1677.329.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091304989.1677.329.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 04:16:29PM -0400, Lee Revell wrote:
> UDP is prone to *much* weirded behavior than TCP in the face of things
> like this.  I once had an NFS server and client using UDP.  A had its
> block size set to 8K, B to 32K.  For some reason the mount succeeded

Thats NFS weirdness. NFS (especially older Linux NFS) is the problem not
the UDP layer. UDP is wonderfully bug free in most situations because
its so simple it forces the bugs up a protocol layer
