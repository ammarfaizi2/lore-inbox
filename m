Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132545AbRDWXCZ>; Mon, 23 Apr 2001 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDWXAS>; Mon, 23 Apr 2001 19:00:18 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64720 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132537AbRDWW7a>;
	Mon, 23 Apr 2001 18:59:30 -0400
Message-ID: <3AE4B3D5.E026E291@mandrakesoft.com>
Date: Mon, 23 Apr 2001 18:59:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: pawel.worach@mysun.com
Cc: Chmouel Boudjnah <chmouel@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810_audio broken?
In-Reply-To: <3829d3430e.3430e3829d@mysun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Worach wrote:
> 
> Ok building mpg123 without eSound worked for me too,
> so guess this is not a Linux kernel issue, sorry for this.
> 
> I tried the fstodell hack but it seems to be obsoluted.
> Now it works without any tweaks.
> 
> eSound sux?

Are you guys running esd with any special arguments?

esd needs a special argument, -r RATE [iirc], in order to tell esd that
it is dealing with a locked rate codec.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
