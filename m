Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292403AbSB0TbO>; Wed, 27 Feb 2002 14:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292901AbSB0Tas>; Wed, 27 Feb 2002 14:30:48 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:59776
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S292907AbSB0TaZ>; Wed, 27 Feb 2002 14:30:25 -0500
Date: Wed, 27 Feb 2002 11:28:11 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: svetljo <galia@st-peter.stw.uni-erlangen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: compiling Linux 2.5.5-dj2 + console_8.diff
In-Reply-To: <3C7D2E2A.8000905@st-peter.stw.uni-erlangen.de>
Message-ID: <Pine.LNX.4.33.0202271123080.13407-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 27 Feb 2002, svetljo wrote:

> vgacon.c: In function `vgacon_do_font_op':
> vgacon.c:816: structure has no member named `vc_sw'
> make[3]: *** [vgacon.o] Error 1

That struct (vc_data) is defined twice, once in linux/vt_kern.h and once
in linux/console_struct.h.

They differ (at least in my tree here).

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fTNPsYXoezDwaVARAjLoAJ0a5T0HBoq3JrtGkLBcGFh03UB4OACfZ0T+
EUO+CThKcRC/x2rj0iwJYxQ=
=/zar
-----END PGP SIGNATURE-----

