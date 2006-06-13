Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWFMIvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFMIvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 04:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWFMIvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 04:51:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:20337 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750794AbWFMIvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 04:51:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q+m7W03v2Sy4HuA3icjYOlwdm8MbqTebGgVQ3g794VrLby0zW7Mm408ijCC1pbDCwwY874hPMYaRlMOOWlqn9b35NipiO89eFRTeluztaIWMjQ0vEFM3OSM8ALY/ADZX3a6GheYyzTgS23oc1aSd00YUuxxTqv7AKPH1QT4TnK0=
Message-ID: <cda58cb80606130151k3d5eac15u163a6bf9eb5dfbcb@mail.gmail.com>
Date: Tue, 13 Jun 2006 10:51:11 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
Cc: apw@shadowen.org,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1150128603.13644.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <448D1117.8010407@innova-card.com>
	 <1150128603.13644.28.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

2006/6/12, Dave Hansen <haveblue@us.ibm.com>:
> On Mon, 2006-06-12 at 09:00 +0200, Franck Bui-Huu wrote:
> > Is it me or the use of CONFIG_SPARSEMEM_EXTREME is really confusing in
> > mm/sparce.c ? Shouldn't we use CONFIG_SPARSEMEM_STATIC instead like
> > the following patch suggests ?
>
> I'll take positive config options over negative ones any day.  I find it
> easier to read things that say what they *are* rather than what they are
> *not*.
>
> In any case, STATIC is really there as an override for architectures to
> say, "I know what I am doing, I use gcc 3.4 and above, or, I don't want
> to use bootmem".  Extreme is really there to say, "I want two-level
> lookups because my memory is extremely sparse."
>
> Make sense?

yes and that's what the patch is trying to show...please take a look
to it and show me what part of the code, used by SPARSEMEM_STATIC
config, is dealing with the two-level lookups.

thanks
-- 
               Franck
