Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSHOKR3>; Thu, 15 Aug 2002 06:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSHOKR3>; Thu, 15 Aug 2002 06:17:29 -0400
Received: from mail-fe71.tele2.ee ([212.107.32.235]:43470 "HELO everyday.com")
	by vger.kernel.org with SMTP id <S316672AbSHOKR2> convert rfc822-to-8bit;
	Thu, 15 Aug 2002 06:17:28 -0400
Date: Thu, 15 Aug 2002 12:21:19 +0200
Message-Id: <200208151021.g7FALJf08062@eday-fe5.tele2.ee>
From: "Thomas Munck Steenholdt" <tmus@get2net.dk>
To: linux-kernel@vger.kernel.org
Subject: promise ultra 133 tx2 lets system standby during use...?
MIME-Version: 1.0
X-EdMessageId: 5408031649485d54571c525d43125c035e54525e1c104b55595966545c4611534078
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having a lot of problems with my Ultra 133 TX2 controller,
that if I boot my system a just doesn't touch it for a while, the system
suspends to complete standby, even though the ext3 data is committed
every 5 secs. causing disk activity and thus should disallow standby
behaviour (at least that's the way it works on my onboard controller).
This has been a problem for ages and I sinerely thought it had been
fixed in the 2.4.19 kernel, and so it seemed for a while, until it
happened again(guess i had to figure out to trigger it once again)
it seems the best way to spot it is to leave the system alone completely,
after a boot - then just wait for an apm standby event to happen.

Any thoughts on this problem?

Best regards
Thomas

-- Send gratis SMS og brug gratis e-mail på Everyday.com -- 

