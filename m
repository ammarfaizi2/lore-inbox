Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbTCTROW>; Thu, 20 Mar 2003 12:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261341AbTCTROW>; Thu, 20 Mar 2003 12:14:22 -0500
Received: from a052082.dsl.fsr.net ([12.32.52.82]:41648 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id <S261296AbTCTROV>;
	Thu, 20 Mar 2003 12:14:21 -0500
Message-ID: <43255.134.121.46.137.1048182821.squirrel@mail.sandall.us>
Date: Thu, 20 Mar 2003 09:53:41 -0800 (PST)
Subject: Re: Deprecating .gz format on kernel.org
From: "Eric Sandall" <eric@sandall.us>
To: <jamie@shareable.org>
In-Reply-To: <20030320002127.GB7887@mail.jlokier.co.uk>
References: <3E78D0DE.307@zytor.com>
        <Pine.LNX.4.44.0303192107270.3901-100000@einstein31.homenet>
        <20030320002127.GB7887@mail.jlokier.co.uk>
X-Priority: 3
Importance: Normal
Cc: <tigran@veritas.com>, <hpa@zytor.com>, <mirrors@kernel.org>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamie Lokier said:
<snip>
> Which is ok of course, but then the signatures don't match any more.
<snip>
> -- Jamie

Why not get the signature from the .tar file, that way the compression
method doesn't matter?  This is how Source Mage does it's checking, we
create and md5sum (and soon GPG) signature based on the uncompressed .tar
file.  This way, you can use any compression you want, even changing
around the compression to your favourite one, and the signatures will
always match.  :)

-Sandalle

-- 
PGP Key 0x5C8D199A5A317214
http://search.keyserver.net:11371/pks/lookup?op=get&search=0x5A317214

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/


