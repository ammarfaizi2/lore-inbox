Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280766AbRLDRmR>; Tue, 4 Dec 2001 12:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRLDRkt>; Tue, 4 Dec 2001 12:40:49 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:44958 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S282910AbRLDRjY>;
	Tue, 4 Dec 2001 12:39:24 -0500
Message-ID: <3C0D0A03.1010609@dplanet.ch>
Date: Tue, 04 Dec 2001 18:38:11 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <20011204173309.A10746@emma1.emma.line.org> <20011204120305.A16578@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Dec 2001 17:39:23.0113 (UTC) FILETIME=[9C64D590:01C17CEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric S. Raymond wrote:

> 
> Oops.  I wasn't going to tell anyone this yet, but since you've made
> this argument I feel I must be up front here....
> 
> After CML2 has proven itself in 2.5, I do plan to go back to Marcelo
> and lobby for him accepting it into 2.4, on the grounds that doing so
> will simplify his maintainance task no end.  That's why I'm tracking
> both sides of the fork in the rulebase, so it will be an easy drop-in
> replacement for Marcelo as well as Linus.
> 


Don't do it!
A stable kernel should be stable also on the building tools.
When Marcelo will correct some grave potential security problem,
the user will rebuild the kernel and it will found that it must
install some other package (machine with 2.4 are now common,
python2 not yet so common) to secure his kernel, it would be
happy.

This is an example, but for a better maintainability you will
give serious problem to the novice kernel user.

	giacomo

BTW there is alreay a punishment for you:
you will resync the variout ARCH, speak with various
subsystem maintainer, ... before to sent path to Marcelo.

