Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131334AbQKAGNu>; Wed, 1 Nov 2000 01:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131349AbQKAGNk>; Wed, 1 Nov 2000 01:13:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7180 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131334AbQKAGN2>; Wed, 1 Nov 2000 01:13:28 -0500
Message-ID: <39FFB429.FA0B58CC@transmeta.com>
Date: Tue, 31 Oct 2000 22:11:53 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <39FF0A71.FE05FAEB@gromco.com> <Pine.LNX.4.10.10010311018180.7083-100000@penguin.transmeta.com> <8tn5q9$iu5$1@cesium.transmeta.com> <20001031211506.E1041@wire.cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> To Keith, Michael and me, the cleanest way to remove duplicates is
> $(sort).  Since some object files must *not* be sorted, we came up with
> a simple, readable way to declare that certain things had to come in a
> certain order -- the idea being that most of the time it would not be
> needed.  Linus disagrees that our solution is simple, readable or
> otherwise desirable.  That's basically the whole issue in a nutshell.
> 

I would tend to agree with Linus on that.  If that's truly what you're
doing, it would be rather nonobvious.

But the question, perhaps, is when does ordering matter.  I'm a little
concerned about things highly dependent on link ordering.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
