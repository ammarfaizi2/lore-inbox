Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267800AbTAHNoR>; Wed, 8 Jan 2003 08:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267801AbTAHNoR>; Wed, 8 Jan 2003 08:44:17 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64393
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267800AbTAHNoR>; Wed, 8 Jan 2003 08:44:17 -0500
Subject: Re: Question for Marcelo
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030108131937.GI823@louise.pinerecords.com>
References: <3E1AFA70.4070200@mindspring.com>
	 <3E1B8E2B.9060200@rackable.com>
	 <1042034152.24099.4.camel@irongate.swansea.linux.org.uk>
	 <20030108131937.GI823@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042036696.24099.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 08 Jan 2003 14:38:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 13:19, Tomas Szepe wrote:
> > [alan@lxorguk.ukuu.org.uk]
> > 
> > I've also dropped rmap out for now.
> 
> Hmm, what for?

15a wasnt working very well, the base VM isn't too bad now and its
a _lot_ easier to do merging with Marcelo without rmap. The other
related bits are seperated out but present (vm overcommit handling,
fixed shmem, removepage callback)

