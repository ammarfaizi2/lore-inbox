Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTAAATA>; Tue, 31 Dec 2002 19:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbTAAATA>; Tue, 31 Dec 2002 19:19:00 -0500
Received: from Mail.CERT.Uni-Stuttgart.DE ([129.69.16.17]:41131 "EHLO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with ESMTP
	id <S264903AbTAAATA>; Tue, 31 Dec 2002 19:19:00 -0500
To: Jason Lunz <lunz@falooley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC with polling support
References: <87el7yrvso.fsf@Login.CERT.Uni-Stuttgart.DE>
	<slrnb13qop.bsm.lunz@stoli.localnet>
Mail-Followup-To: Jason Lunz <lunz@falooley.org>,
 linux-kernel@vger.kernel.org
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Wed, 01 Jan 2003 01:27:24 +0100
In-Reply-To: <slrnb13qop.bsm.lunz@stoli.localnet> (Jason Lunz's message of
 "Tue, 31 Dec 2002 19:07:21 +0000 (UTC)")
Message-ID: <87k7hpr9xv.fsf@Login.CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz <lunz@falooley.org> writes:

> Weimer@CERT.Uni-Stuttgart.DE said:
>> Any suggestions which card I should use?  The driver has to be open
>> source, and the card shouldn't be too expensive (i.e. in the usual
>> price range of brand 100BaseTX NICs).
>
> linux 2.4.20 supports NAPI for tg3 only. I have patches for e1000,
> 3c59x, tulip, and eepro100 at:

Thanks, the 3c59x patches are interesting, but they contain a few
_very_ discouraging comments. :-(

I might give the e100 patches a try, or borrow/buy an e1000 card--does
a "PRO/1000 MT Desktop Adapter" do it?

If I go the e100 route, does it matter much which chip the card is
built around?  (The CPU Saver feature seems to be available only on
82558/9, and I haven't found those yet.)

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          fax +49-711-685-5898
