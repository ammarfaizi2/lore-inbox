Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129088AbQKCHWr>; Fri, 3 Nov 2000 02:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130134AbQKCHWa>; Fri, 3 Nov 2000 02:22:30 -0500
Received: from cc993546-b.srst1.fl.home.com ([24.3.77.52]:13828 "EHLO
	comptechnews.com") by vger.kernel.org with ESMTP id <S129166AbQKCHWY>;
	Fri, 3 Nov 2000 02:22:24 -0500
From: "Robert B. Easter" <reaster@comptechnews.com>
Date: Fri, 3 Nov 2000 02:30:03 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: TimO <hairballmt@mcn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-via@gtf.org
To: linux-via@havoc.gtf.org, Vojtech Pavlik <vojtech@suse.cz>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <39E54117.37461BD1@mandrakesoft.com> <3A00F515.45D67F1C@mandrakesoft.com> <20001102084052.A862@suse.cz>
In-Reply-To: <20001102084052.A862@suse.cz>
Subject: Re: Announce: Via audio driver update
MIME-Version: 1.0
Message-Id: <00110302300301.03733@comptechnews>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 November 2000 02:40, Vojtech Pavlik wrote:
> On Thu, Nov 02, 2000 at 12:01:09AM -0500, Jeff Garzik wrote:
> > Please grab 1.1.14, there were a number of bug fixes since 1.1.10.  You
> > can get this version in the recently-released 2.4.0-test10 kernel, or
> > download from http://sourceforge.net/projects/gkernel/
>
> Hi!
>
> I'd like to report a bug, too. On my system, with the test10 kernel,
> regardless of what frequency the software sets, the data is always
> played at 48 KHz.
>
> Via 686a audio driver 1.1.14
> ac97_codec: AC97 Audio codec, id: 0x574d:0x4c00 (Wolfson WM9704)
> via82cxxx: board #1 at 0xDC00, IRQ 10
>
> The codec doesn't support variable rate input, as far as I know. Could
> that be the cause?

What is the difference between the VIA686A kernel distribution audio driver 
and the VIA686a module provided by ALSA (which works fine)?  It seems like 
ALSA provides a fully functioning VIA686a module.  Why the duplication of 
effort/re-coding?  I suppose there is some major difference that I don't 
understand?

-- 
-------- Robert B. Easter  reaster@comptechnews.com ---------
- CompTechNews Message Board   http://www.comptechnews.com/ -
- CompTechServ Tech Services   http://www.comptechserv.com/ -
---------- http://www.comptechnews.com/~reaster/ ------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
