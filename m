Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262097AbRESTkH>; Sat, 19 May 2001 15:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbRESTjt>; Sat, 19 May 2001 15:39:49 -0400
Received: from mx2.utanet.at ([195.70.253.46]:24202 "EHLO smtp1.utaiop.at")
	by vger.kernel.org with ESMTP id <S262106AbRESTj1>;
	Sat, 19 May 2001 15:39:27 -0400
Message-ID: <3B06E7C4.C19F1870@grips.com>
Date: Sat, 19 May 2001 23:38:12 +0200
From: Gerold Jury <gjury@grips.com>
Organization: Grips
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-xfs i686)
X-Accept-Language: de-AT, en
MIME-Version: 1.0
To: Vitaly Luban <vitaly@luban.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: [PATCH][RFC] Signal-per-fd for RT signals
In-Reply-To: <3B05D498.1E91B43C@luban.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Luban wrote:
> 
> Hi,
> 
<snip/>
> the form of POLL_... This will bring functionality of RT
> signals event notification on the level with 'select' or
> 'poll' one, while more efficient and scalable. If there's
> an interest in such a feature, I'd be eager to publish a
> patch.
> 
> Thanks,
>     Vitaly.
> 
I have been waiting for this patch since 2.4.0.

The SIGIO signal is a nightmare when it arrives :
  The machine is already under high load and has to stop
  using the most efficient way to handle it.

The filter changes would be the cream on top of this patch.
Do not hurry, but please not for long.

best Regards

Gerold
