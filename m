Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRAOUQD>; Mon, 15 Jan 2001 15:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRAOUPp>; Mon, 15 Jan 2001 15:15:45 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39951 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131219AbRAOUPi>; Mon, 15 Jan 2001 15:15:38 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is sendfile all that sexy?
Date: 15 Jan 2001 12:15:08 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <93vloc$keg$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10101141436010.4613-100000@penguin.transmeta.com> <3A622C25.766F3BCE@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A622C25.766F3BCE@pobox.com>
By author:    J Sloan <jjs@pobox.com>
In newsgroup: linux.dev.kernel
>
> Linus Torvalds wrote:
> 
> > Of course, you may be right on wuftpd. It obviously wasn't designed with
> > security in mind, other alternatives may be better.
> 
> I run proftpd on all my ftp servers - it's fast, configurable
> and can do all the tricks I need - even red hat seems to
> agree that proftpd is the way to go.
> 
> Visit any red hat ftp site and they are running proftpd -
> 
> So, why do they keep shipping us wu-ftpd instead?
> 
> That really frosts me.
> 

proftpd is not what you want for an FTP server whose main function is
*non-*anonymous access.  It is very much written for the sole purpose
of being a great FTP server for a large anonymous FTP site.  If you're
running a site large enough to matter, you can replace an RPM or two.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
