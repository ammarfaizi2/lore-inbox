Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWHMO0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWHMO0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 10:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWHMO0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 10:26:23 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:20603 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751262AbWHMO0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 10:26:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hMF9wDcgPdqbYsJyjPpKMXhIG47zD/F0L29E5jmkkiBVzHeh05RPMJ8UnwGIj4u1KqWHT8y9WwpI+UAIDoNjzU78z4F9ykSFz1RMHwejHnRWnRgv3lngYLstoIku03i1HCyQi43H8YY8p4agsWGcwHYFDhXfR0Bj8m2/RAODnSQ=
Message-ID: <6bffcb0e0608130726x8fc1c0v7717165a63391e80@mail.gmail.com>
Date: Sun, 13 Aug 2006 16:26:22 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
	 <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> Hi Michal,
>
> On 13/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > Can you look at this?
> >
> =======================================================
> > [ INFO: possible circular locking dependency detected ]
>
> Thanks for this. Did you get this with the previous version of
> kmemleak (0.8) or you just tried it now.

It's kmemleak 0.9 issue. I have tested kmemleak 0.8 on 2.6.18-rc1and
2.6.18-rc2. I haven't seen this before.

>
> I'll have a look.
>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
