Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWA3UU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWA3UU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWA3UUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:20:55 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:39104 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964944AbWA3UUz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:20:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O9k8fy4zvzOASXYayeaWj4mW4CdNPhx/hJ937iY8nV6ItByvy88LuqBkWLVru1aYWqskpJ3d5WuqlU1apXghEo1aPFhKHNqSjpuFbpo/OBwjzOtk8GYwmnIyjKgsF8xfJy+elTIhhCYK+yLqAFElQvFq9icUvrD3v7lYY/nIpFk=
Message-ID: <84144f020601301210t7b65afc9q92f1c37cf45b8d75@mail.gmail.com>
Date: Mon, 30 Jan 2006 22:10:52 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Mauro Tassinari <mtassinari@cmanet.it>
Subject: Re: Xorg crashes 2.6.16-rc1-git4
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAA4yaMCiudb0KOneWGMjylOQEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAwPo5BClV1USIJnF2WU6HIAEAAAAA@cmanet.it>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAA4yaMCiudb0KOneWGMjylOQEAAAAA@cmanet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/30/06, Mauro Tassinari <mtassinari@cmanet.it> wrote:
> > My test system running vanilla 2.6.16-rc1 (slackware-current
> > config) freezes dead as soon as Xorg is started.
> >
> > Only a reset is possible, so no info can be gathered after the crash.
> >
> > Kernel 2.6.15 works flawlessy.
> >
>
> same applyes to rc1-git4
>
> see previous message for details.

Your bug report doesn't have much to work with. Perhaps you could use
git bisect to find out which changeset broke your kernel. Please refer
to the following URL for details:

http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

                             Pekka
