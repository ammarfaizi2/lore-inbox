Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263168AbTCSVAt>; Wed, 19 Mar 2003 16:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263169AbTCSVAt>; Wed, 19 Mar 2003 16:00:49 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:16003 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S263168AbTCSVAs>; Wed, 19 Mar 2003 16:00:48 -0500
Date: Wed, 19 Mar 2003 21:12:03 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein31.homenet
To: "H. Peter Anvin" <hpa@zytor.com>
cc: mirrors <mirrors@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
In-Reply-To: <3E78D0DE.307@zytor.com>
Message-ID: <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, H. Peter Anvin wrote:
> i) Does this sound reasonable to everyone?  In particular, is there any
> loss in losing the "original" compressed files?

No, there is at least one reason for the "original" .gz files. Here are 
the logical steps:

a) any Linux distribution contains their own "linux" package with the 
source base being "vanilla" Linux .tar.gz file

b) switching such to .tar.bz2 will make building the package longer
because of longer extract times

c) re-running tar to generate a .tar.gz from .tar.bz2 and store the 
.tar.gz instead will make customers suspicious --- i.e. they will have to 
ask "is this _really_ a plain Linux tree or do I need to run diff(1) to 
verify, just in case?"

See the reasoning? However, I agree that this reason is very weak. But you
were interested in any reasons, including weak ones,  I assume :)

Regards
Tigran

> 
> ii) Assuming a yes on the previous question, what time frame would it
> make sense for this changeover to happen over?
> 
> 	-hpa
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

