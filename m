Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIOtt>; Tue, 9 Jan 2001 09:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRAIOtj>; Tue, 9 Jan 2001 09:49:39 -0500
Received: from Cantor.suse.de ([194.112.123.193]:2064 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129324AbRAIOt0>;
	Tue, 9 Jan 2001 09:49:26 -0500
Date: Tue, 9 Jan 2001 15:49:08 +0100
From: Hubert Mantel <mantel@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
Message-ID: <20010109154908.F20539@suse.de>
Mail-Followup-To: Hubert Mantel <mantel@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3A55447D.995FB159@goingware.com> <9350df$2md$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9350df$2md$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jan 05, 2001 at 09:31:27AM -0800
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.2.16
X-PGP-Key: 1024D/B0DFF780, 1024R/CB848DFD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, Linus Torvalds wrote:

[...]

> But that's very different from having somebody like RedHat, SuSE or
> Debian make such a kernel part of their standard package. No, I don't
> expect that they'll switch over completely immediately: that would show
> a lack of good judgement. The prudent approach has always been to have
> both a 2.2.19 and a 2.4.0 kernel on there, and ask the user if he wants
> to test the new kernel first.

Right, but now there is a problem: Software RAID. The RAID code of 2.4.0
is not backwards compatible to the one in 2.2.18; if somebody has used
2.4.0 on softraid and discovers some problem, he can not switch back to
some official 2.2 kernel. In order to make it possible to switch between
kernel releases, every vendor now really is forced to integrate the new
RAID0.90 code to their 2.2 kernel. IMHO this code should be integrated to
the next official 2.2 kernel so people can use whatever they want.

> 		Linus
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
