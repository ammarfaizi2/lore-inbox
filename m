Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132372AbRDWWHm>; Mon, 23 Apr 2001 18:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDWWHY>; Mon, 23 Apr 2001 18:07:24 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29648 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132338AbRDWWHB>;
	Mon, 23 Apr 2001 18:07:01 -0400
Message-ID: <3AE4A785.79A3F47E@mandrakesoft.com>
Date: Mon, 23 Apr 2001 18:07:01 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pawel.worach@mysun.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio broken?
In-Reply-To: <3804336226.3622638043@mysun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Worach wrote:
> sorry the kernel version is 2.4.3-ac12, so it's kind of latest...
> 
> I was using mpg123 (xmms and c/o does exactly the same)
> if I run it like this Moby sounds very stupid... :)

"very stupid" means "broken" obviously, but can you be more specific? 
music is faster? slower?  garbled?

> [root@whyami mp3]# mpg123 -r 48000 Moby_01.wav.mp3
> unsupported playback rate: 44100
> Audio device open for 44.1Khz, stereo, 16bit failed
> Trying 44.1Khz, 8bit stereo.
> unsupported sound format: 32
> Audio device open for 44.1Khz, stereo, 8bit failed
> Trying 48Khz, 16bit stereo.

so, since you provided no more output than this, I assume that
48Khz/16bit succeeded, which appears perfectly normal for a locked-rate
codec.

You may need the 'clocking' module option, not sure...

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
