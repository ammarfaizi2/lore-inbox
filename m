Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbRGJXyI>; Tue, 10 Jul 2001 19:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbRGJXx6>; Tue, 10 Jul 2001 19:53:58 -0400
Received: from [212.159.14.225] ([212.159.14.225]:62159 "HELO
	murphys-outbound.servers.plus.net") by vger.kernel.org with SMTP
	id <S267179AbRGJXx4>; Tue, 10 Jul 2001 19:53:56 -0400
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: Rob Landley <landley@webofficenow.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu>
	<01070912485904.00705@localhost.localdomain>
	<20010710121724.Z1503@niksula.cs.hut.fi>
From: Adam Sampson <azz@gnu.org>
Organization: The Society Of People Who Repeatedly Point Out That "alot" And "allot" Are Both Wrong, And It Should Be Written "a lot"
Date: 10 Jul 2001 22:24:21 +0100
In-Reply-To: <20010710121724.Z1503@niksula.cs.hut.fi>
Message-ID: <87ith0a35m.fsf@cartman.azz.us-lot.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@niksula.hut.fi> writes:

> It is coded is assembly specificly to heat the CPU as much as possible. See
> the README for details, but it seems that floating point operations are
> tougher than integers and MMX can be even harder (depending on CPU model, of
> course). Not sure what kind of role SSE, SSE2, 3dNow! play these days.
> Perhaps Alan knows?

I would have thought this would be a nice problem for a genetic
algorithm to solve---start with random blocks of data, execute them
repeatedly for a period of time (restarting upon CPU traps), and
"breed" those that cause the greatest temperature increase. Any bored
research students out there?

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
