Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130157AbRATSOp>; Sat, 20 Jan 2001 13:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbRATSOf>; Sat, 20 Jan 2001 13:14:35 -0500
Received: from smtp5.libero.it ([193.70.192.55]:4821 "EHLO smtp5.libero.it")
	by vger.kernel.org with ESMTP id <S130200AbRATSO0>;
	Sat, 20 Jan 2001 13:14:26 -0500
Message-ID: <3A69D570.BCA00B6E@alsa-project.org>
Date: Sat, 20 Jan 2001 19:14:08 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Andrea Arcangeli <andrea@suse.de>, mingo@elte.hu, torvalds@transmeta.com,
        raj@cup.hp.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <200101201728.UAA04351@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> 
> > The manpage disagrees with you:
> 
> Do you jest?
> 
> This manpages is wrong, or, to be more exact, is incomplete,
> which is common flaw of them.
> 
> get/set mean nothing but read-only/changing, i.e.
> another important property missing in ioctl interface.

setsockopt i.e. set socket options

I think that Andrea's point is that SIOCPUSH don't set anything (i.e.
don't change a state), but ask for an action to be done now.

For this reason the name setsockopt is counter intuitive (apart from man
page) and it seems to violate the principle of least surprise.

I think this point of view is easily agreeable.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
