Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSG2NKr>; Mon, 29 Jul 2002 09:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316999AbSG2NKr>; Mon, 29 Jul 2002 09:10:47 -0400
Received: from rogue.ncsl.nist.gov ([129.6.101.41]:36822 "EHLO
	rogue.ncsl.nist.gov") by vger.kernel.org with ESMTP
	id <S316935AbSG2NKk>; Mon, 29 Jul 2002 09:10:40 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml] Re: About the need of a swap area
References: <3D42907C.mailFS15JQVA@viadomus.com>
	<20020727144228.GQ1548@niksula.cs.hut.fi>
	<3D42C62F.mail5XQ31DIAC@viadomus.com>
	<20020727170124.GR1465@niksula.cs.hut.fi>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: 29 Jul 2002 09:14:01 -0400
In-Reply-To: <20020727170124.GR1465@niksula.cs.hut.fi>
Message-ID: <9cffzy2brs6.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@niksula.hut.fi> writes:

> > How to configure it?
> 
> Through the tunables in /proc/sys/vm/.

By the way, speaking of /proc/sys, could we decide on either hyphens,
or underscores, but not both?

# ls /proc/sys/vm
bdflush  max_map_count  min-readahead      page-cluster
kswapd   max-readahead  overcommit_memory  pagetable_cache

(this is 2.4.19-rc3)

I'd submit a patch except the asbestos underwear is in the wash
today.  (IOW, I don't know which would be preferred... I suspect
underscores.)

ian
