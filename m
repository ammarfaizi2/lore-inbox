Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313926AbSDQU4s>; Wed, 17 Apr 2002 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSDQU4r>; Wed, 17 Apr 2002 16:56:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34549
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313926AbSDQU4r>; Wed, 17 Apr 2002 16:56:47 -0400
Date: Wed, 17 Apr 2002 13:58:49 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, david.lang@digitalinsight.com,
        vojtech@suse.cz, rgooch@ras.ucalgary.ca, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 IDE 36
Message-ID: <20020417205849.GA574@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"David S. Miller" <davem@redhat.com>, david.lang@digitalinsight.com,
	vojtech@suse.cz, rgooch@ras.ucalgary.ca, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020416.100610.115916272.davem@redhat.com> <20020416174022.25545@smtp.wanadoo.fr> <3CBD2847.6010003@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 09:46:15AM +0200, Martin Dalecki wrote:
> Benjamin Herrenschmidt wrote:
> >something scary. I beleive the sanest solution that won't please
> >affected people is to _not_ support DMA on these broken HW ;)
> 
> No: the sane sollution would be to not support swapping disks between
> those systems and other systems.

Martin,

Go ahead and remove the byte swaping code for now, since it is a development
kernel after all...

*But*, make sure you put that on your to do list to add it back in a "sane"
way.
