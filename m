Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262742AbREOMTj>; Tue, 15 May 2001 08:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbREOMT3>; Tue, 15 May 2001 08:19:29 -0400
Received: from www.topmail.de ([212.255.16.226]:34291 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S262742AbREOMTV>;
	Tue, 15 May 2001 08:19:21 -0400
From: mirabilos <eccesys@topmail.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Device Numbers, LILO
Message-Id: <20010515121635.B5C402F84AC@www.topmail.de>
Date: Tue, 15 May 2001 14:16:35 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>That's not the issue.  LILO takes whatever you pass to root= and converts
>it to a device number at /sbin/lilo time.  An idiotic practice on the
>part of LILO, in my opinion, that ought to have been fixed a long time
>ago.

That's why you have to use append="root=blah" for devfs :)
Really it should have been in IMO. Btw, is LBA support in?
Last time I saw a LILO manpage it stated that "linear" still
is restricted to 16bit (65535 sectors) which normally is much
less than 1k cylinders...

-mirabilos
-- 
by telnet
