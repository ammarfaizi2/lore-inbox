Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131458AbRCNQDj>; Wed, 14 Mar 2001 11:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRCNQDa>; Wed, 14 Mar 2001 11:03:30 -0500
Received: from hera.cwi.nl ([192.16.191.8]:60652 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131460AbRCNQDQ>;
	Wed, 14 Mar 2001 11:03:16 -0500
Date: Wed, 14 Mar 2001 17:01:34 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103141601.RAA189084.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, linus@transmeta.com, rhw@memalpha.cx
Subject: Re: [PATCH] Improved version reporting
Cc: linux-kernel@vger.kernel.org, seberino@spawar.navy.mil
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 10:39:53AM +0000, Riley Williams wrote:

> -o  util-linux             2.10o                   # fdformat --version
> +o  util-linux         #   2.10o        # fdformat --version

Looking at fdformat to get the util-linux version is perhaps
not the most reliable way - some people have fdformat from fd-utils or so.
Using mount --version would be better - I am not aware of any
other mount distribution.

> +In addition, it is wise to ensure that the following packages are at least
> +at the versions suggested below, although these may not be required,
> +depending on the exact configuration of your system:
> +
> +o  Console Tools      #   0.3.3        # loadkeys -V
> +o  Mount              #   2.10e        # mount --version

Concerning mount: (i) the version mentioned is too old,
(ii) mount is in util-linux. Conclusion: the mount line
should be deleted entirely.
Concerning Console Tools: maybe kbd-1.05 is uniformly better.
I am not aware of any reason to recommend the use of console-tools.

Andries
