Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWFSRfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWFSRfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWFSRfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:35:52 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:34211 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751259AbWFSRfv
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:35:51 -0400
To: reiser@namesys.com
CC: nix@esperi.org.uk, akpm@osdl.org, vs@namesys.com, hch@infradead.org,
       Reiserfs-Dev@namesys.com, Linux-Kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, drepper@redhat.com
In-reply-to: <4496D34F.4010007@namesys.com> (message from Hans Reiser on Mon,
	19 Jun 2006 09:39:43 -0700)
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>	<44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>	<1149766000.6336.29.camel@tribesman.namesys.com>	<20060608121006.GA8474@infradead.org>	<1150322912.6322.129.camel@tribesman.namesys.com>	<20060617100458.0be18073.akpm@osdl.org> <4494411B.4010706@namesys.com> <87ac8an21r.fsf@hades.wkstn.nix> <449668D1.1050200@namesys.com> <E1FsHzf-0004ES-00@dorka.pomaz.szeredi.hu> <4496D34F.4010007@namesys.com>
Message-Id: <E1FsNeQ-0004pV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Jun 2006 19:35:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would think that batched write is pretty essential then to FUSE
> performance.

Well, yes essential if the this is the bottleneck in write throughput,
which is most often not the case, but sometimes it is.

Miklos
