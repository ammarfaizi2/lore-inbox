Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbRABAv7>; Mon, 1 Jan 2001 19:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRABAvt>; Mon, 1 Jan 2001 19:51:49 -0500
Received: from hermes.mixx.net ([212.84.196.2]:49668 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129627AbRABAvj>;
	Mon, 1 Jan 2001 19:51:39 -0500
Message-ID: <3A511E50.6C49FE8C@innominate.de>
Date: Tue, 02 Jan 2001 01:18:24 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Read <rread@datarithm.net>, linux-kernel@vger.kernel.org
Subject: Re: PC-speaker control
In-Reply-To: <01010118360105.00896@rafael> <20010101230553.B8481@tenchi.datarithm.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Read wrote:
> Try this on the console:
> 
> setterm -blength 0
> 
> no assembly required. :)

Yes, and my xterm still beeps - if I make that go away then something
else will beep.

Somebody posted a patch to do a global disable of the speaker some time
back, and I wish that the patch were generally available.  The result of
not having the global disable is an office full of beeping computers.

How does this look:

  cat 0 >/proc/sys/dev/speaker/beep

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
