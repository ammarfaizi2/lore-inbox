Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279418AbRJWM44>; Tue, 23 Oct 2001 08:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279415AbRJWM4q>; Tue, 23 Oct 2001 08:56:46 -0400
Received: from dark.pcgames.pl ([195.205.62.2]:3785 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S279416AbRJWM41>;
	Tue, 23 Oct 2001 08:56:27 -0400
Date: Tue, 23 Oct 2001 14:55:45 +0200 (CEST)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
cc: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: bug in "raid5: measuring checksumming speed"
In-Reply-To: <Pine.LNX.4.10.10110201225250.7732-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0110231454120.17198-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Oct 2001, Mark Hahn wrote:

> I haven't looked at the code, but I'm guessing the sse code uses
> NTA instructions that avoid polluting the cache.  that's far more
> of an advantage than a small difference in speed.  especially since
> it's physically impossible that you'll be using more than say,
> 200 MB/s.
Ok :) I agree. But this behaviour looks strange at first time.
I think kernel should print a message like "Forced using pIII_sse".

Best regards,


                                Krzysztof Oledzki


