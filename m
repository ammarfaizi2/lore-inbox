Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVHPXL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVHPXL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVHPXL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:11:29 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:6101 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750727AbVHPXL2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:11:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JIFjWdd60lNFaNLFE72uzGmQf9QejFgyJEAshnf/tTI94sl22am2xQGc8BOUC9iFOJF9YVnBV7SclpGTLuBxrtY79AMwBnR1RBu2Ue0gAUFa2Vy8Ql+ma21MgLkbQRZCwL6nMwhLZyghWGLDsBxynZ9dReFeYhvNllaeib2HOFo=
Message-ID: <5a2cf1f605081616116ba521ab@mail.gmail.com>
Date: Wed, 17 Aug 2005 01:11:26 +0200
From: jerome lacoste <jerome.lacoste@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
Cc: lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
In-Reply-To: <1124228482.8630.95.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a2cf1f6050816031011590972@mail.gmail.com>
	 <1124228482.8630.95.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, john stultz <johnstul@us.ibm.com> wrote:
> On Tue, 2005-08-16 at 12:10 +0200, jerome lacoste wrote:
> > Installed stock 2.6.12.3 on a brand new amd64 box with an Asus extreme
> > AX 300 SE/t mainboard.
> >
> > I remember seeing a message in the boot saying something along:
> >
> >   "cannot connect to hardware clock."
> >
> > And now I see that the time is changing too fast (about 2 seconds each second).
> [snip]
> > 0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5951
> 
> Looks like the AMD/ATI bug.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=3927

Sounds like it. I will have to try the patch.

Good catch John!

Jerome
