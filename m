Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267732AbTBRIvv>; Tue, 18 Feb 2003 03:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267735AbTBRIvu>; Tue, 18 Feb 2003 03:51:50 -0500
Received: from terminus.zytor.com ([63.209.29.3]:20612 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S267732AbTBRIvl>; Tue, 18 Feb 2003 03:51:41 -0500
Message-ID: <1144.62.20.229.212.1045558700.squirrel@www.zytor.com>
Date: Tue, 18 Feb 2003 00:58:20 -0800 (PST)
Subject: Re: [RFC] klibc for 2.5.59 bk
From: "H. Peter Anvin" <hpa@zytor.com>
To: <jgarzik@pobox.com>
In-Reply-To: <3E512BCB.1010000@pobox.com>
References: <20030209125759.GA14981@kroah.com>
        <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>
        <20030217180246.GA26112@mars.ravnborg.org>
        <1911.212.181.176.76.1045505249.squirrel@www.zytor.com>
        <3E512BCB.1010000@pobox.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <hpa@zytor.com>, <sam@ravnborg.org>, <kai@tp1.ruhr-uni-bochum.de>,
       <greg@kroah.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Maintaining gcc compatibility need not imply this annoyance.  This has
> been fixed in 2.5.x for ages, for the main kernel build, and I recently
> fixed it in 2.4.x by the attached patch.  We just need to move that fix
> over to klibc build...
>


Of course it doesn't ... it's a matter of detecting if the -f options are
usable.  It was more of a complaint at the gcc team.

However, I can personally vouch for that it's *not* fixed for the main
kernel build as of 2.5.61.

    -hpa



