Return-Path: <linux-kernel-owner+w=401wt.eu-S932557AbWLLW6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWLLW6l (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWLLW6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:58:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4742 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932557AbWLLW6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:58:40 -0500
Date: Tue, 12 Dec 2006 23:58:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usage of linux/types.h wrt to install_headers
Message-ID: <20061212225847.GZ28443@stusta.de>
References: <8bd0f97a0612061503u4318c299ja0e06b30509ca34d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bd0f97a0612061503u4318c299ja0e06b30509ca34d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 06:03:50PM -0500, Mike Frysinger wrote:
> there are a plethora of headers that cannot be included straight due
> to the usage of __ types (like __u32) without first including
> linux/types.h ... so the question is, should all of these headers be
> fixed to properly pull in linux/types.h first or are users expected to
> "just know" the correct order of headers ?  in my mind, pretty much
> every header is fair game for straight "#include <header>" usage and
> requiring a list of headers to be pulled in properly is ignoring the
> problem ...

Yes, they should all be fixed to #include <linux/types.h>.

> -mike

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

