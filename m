Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284965AbRLQC1p>; Sun, 16 Dec 2001 21:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284968AbRLQC1e>; Sun, 16 Dec 2001 21:27:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46858 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284965AbRLQC10>; Sun, 16 Dec 2001 21:27:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Is /dev/shm needed?
Date: 16 Dec 2001 18:26:57 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9vjl5h$1c6$1@cesium.transmeta.com>
In-Reply-To: <E16Fkqc-0001Z0-00@DervishD.viadomus.com> <20011216234748.3EDE9FB80D@tabris.net> <E16Fl8j-0000nA-00@phalynx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16Fl8j-0000nA-00@phalynx>
By author:    Ryan Cumming <bodnar42@phalynx.dhs.org>
In newsgroup: linux.dev.kernel
>
> On December 16, 2001 15:47, Adam Schrotenboer wrote:
> > I may be wrong about /tmp as well, but I have come to think that it is data
> > that ought be discarded after logout, and have sometimes considered writing
> > a script for it in the login/logout scripts.
> 
> System daemons can legally use /tmp, and they may not apprechiate having 
> their files removed from underneath them everytime someone telnets in. ;)
> 

Not to mention when you kill a secondary session.  It's bogus.
However, discarding /tmp on *REBOOT* is legitimate.

	 -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
