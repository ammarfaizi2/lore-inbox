Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSGUXuH>; Sun, 21 Jul 2002 19:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSGUXuH>; Sun, 21 Jul 2002 19:50:07 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:23176 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315427AbSGUXuD>; Sun, 21 Jul 2002 19:50:03 -0400
Date: Sun, 21 Jul 2002 18:53:02 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 correct inconsistent keyboard maps
In-Reply-To: <28252.1025930632@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0207211849001.16927-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2002, Keith Owens wrote:

> The Makefiles that generate keyboard maps and the shipped files which
> are used when loadkeys is not installed are inconsistent.  Some
> Makefiles remove static, others do not.  Some shipped files have static
> removed, others do not.  Make them consistent.

Did you check that this cannot cause multiply defined symbols depending on 
arch/.config? (I did not, I don't even know why these cannot be static 
everywhere, but since I guess you did look at this when you did the 
change, I thought I may be able to save that effort)

--Kai


