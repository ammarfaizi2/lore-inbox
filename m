Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289164AbSAJEd5>; Wed, 9 Jan 2002 23:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289163AbSAJEdl>; Wed, 9 Jan 2002 23:33:41 -0500
Received: from nile.gnat.com ([205.232.38.5]:2710 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289161AbSAJEd0>;
	Wed, 9 Jan 2002 23:33:26 -0500
From: dewar@gnat.com
To: dewar@gnat.com, tim@hollebeek.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, gcc@gcc.gnu.org, groudier@free.fr,
        jamagallon@able.es, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        paulus@samba.org, trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020110043323.9704DF28C6@nile.gnat.com>
Date: Wed,  9 Jan 2002 23:33:23 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a; b = 1;

yes, that's a permissible transformation, and it is interesting to note
that the normally useless C statement

 a;

has a useful meaning for volatile variables :-)
