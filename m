Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVADSOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVADSOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVADSOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:14:19 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:41021 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261802AbVADSN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:13:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=supm/A3JoicDo+Fv1TT90GqSkZibDgVqyNRkjUm9P2j+5UXvtzYJQm82EEy0Wkh7HXyr1FxGM4Qbn1ICh30BYC5io5unW3/52bG8mmaTrrwKJS7W6v/0vm+NyT0Bxwg5Xs4yVWKoCvpW4jYpvlYsmiGNXjpiOYaTa7z2gOrxzF4=
Message-ID: <d120d500050104101339d7b5a1@mail.gmail.com>
Date: Tue, 4 Jan 2005 13:13:54 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [bk patches] Long delayed input update
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0501041002060.2294@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041227142821.GA5309@ucw.cz>
	 <200412271419.46143.dtor_core@ameritech.net>
	 <20050103131848.GH26949@ucw.cz>
	 <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org>
	 <20050104135859.GA9167@ucw.cz>
	 <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
	 <20050104160830.GA13125@ucw.cz>
	 <Pine.LNX.4.58.0501040812420.2294@ppc970.osdl.org>
	 <d120d50005010408232e29661@mail.gmail.com>
	 <Pine.LNX.4.58.0501041002060.2294@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 10:03:19 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Tue, 4 Jan 2005, Dmitry Torokhov wrote:
> >
> > i8042-style ports are not limited to PC - maceps2.c, q40kbd.c,
> > rpckbd.c and sa1111ps2.c also implement them that's why libps2 wasn't
> > limited to x86 arch.
> 
> So?
>

I was referring to your statement that on PCs it is selected
automatically as if only PC can use libps2.
 
> If you select ATKBD then LIBPS2 should be selected _automatically_.
> 
> My point is that there is _never_ a reason to ask about it. Ever.

I'll code some tiny PS/2 driver and will keep it out of the tree just
to prove you wrong ;)

-- 
Dmitry
