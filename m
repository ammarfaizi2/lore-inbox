Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRABBOK>; Mon, 1 Jan 2001 20:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbRABBOB>; Mon, 1 Jan 2001 20:14:01 -0500
Received: from hermes.mixx.net ([212.84.196.2]:5893 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129763AbRABBNz>;
	Mon, 1 Jan 2001 20:13:55 -0500
Message-ID: <3A51238B.334692F0@innominate.de>
Date: Tue, 02 Jan 2001 01:40:43 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PC-speaker control
In-Reply-To: <01010118360105.00896@rafael> <20010101230553.B8481@tenchi.datarithm.net> <3A511E50.6C49FE8C@innominate.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> Robert Read wrote:
> > Try this on the console:
> >
> > setterm -blength 0
> >
> > no assembly required. :)
> 
> Yes, and my xterm still beeps - if I make that go away then something
> else will beep.
> 
> Somebody posted a patch to do a global disable of the speaker some time
> back, and I wish that the patch were generally available.  The result of
> not having the global disable is an office full of beeping computers.
> 
> How does this look:
> 
>   cat 0 >/proc/sys/dev/speaker/beep

eh,

  echo 0 >/proc/sys/dev/speaker/beep

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
