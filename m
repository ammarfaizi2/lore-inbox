Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbVD2F7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVD2F7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVD2F7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:59:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:10457 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262394AbVD2F7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:59:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/4] ppc64: Add driver for BPA iommu
Date: Fri, 29 Apr 2005 07:48:27 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>
References: <200504190318.32556.arnd@arndb.de> <200504290635.44965.arnd@arndb.de> <20050429053615.GA30219@lixom.net>
In-Reply-To: <20050429053615.GA30219@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290748.30055.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 29 April 2005 07:36, Olof Johansson wrote:
> On Fri, Apr 29, 2005 at 06:35:43AM +0200, Arnd Bergmann wrote:
>>
> Anyhow, enum or #define, it should be moved to bpa_iommu.h.

I don't interface with any other files, so I prefer to have
everything in one file here. If there is anyone else who
agrees with you on moving this into a separate file, I don't
mind doing that.

> User or developer error? I thought it was a developer one, and a quite
> specialized one at that. Either way, there's already a primitive that
> can be used instead of making your own: BUILD_BUG_ON().

Right. I had forgotten about that, thanks.
 
> > Yes, but it seems to contradict the specs...
> 
> A comment to that effect could be nice.

Ok, I'll change that.

> > This comes from a graphical representation in the specs. I'll add a comment
> > to point to that image.
> 
> I guess it'd be a bit much information to just add in a comment, but for
> readability that's probably the best way to go.  Not many people have
> the specs, but on the other hand if you're messing around with this code
> then chances are you have them.

The picture should be in the parts that we are working on getting public.

> I don't know what the status is for a release of public specifications,
> but if they're not available then people will be looking to learn from
> the implementation and the documentation around it instead.

There will be a supplement to Book 1-3 of PowerPC AS that is going to
be public. Book 4 is rarely needed and the chances of publishing that
are not as good.

Thanks,

	Arnd <><
