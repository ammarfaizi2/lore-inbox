Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSCYLvB>; Mon, 25 Mar 2002 06:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312405AbSCYLuw>; Mon, 25 Mar 2002 06:50:52 -0500
Received: from AMontpellier-201-1-4-206.abo.wanadoo.fr ([217.128.205.206]:50654
	"EHLO awak") by vger.kernel.org with ESMTP id <S312393AbSCYLup> convert rfc822-to-8bit;
	Mon, 25 Mar 2002 06:50:45 -0500
Subject: Re: [PATCH] 3c59x and resume
From: Xavier Bestel <xavier.bestel@free.fr>
To: Joachim Breuer <jmbreuer@gmx.net>
Cc: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        christophe =?ISO-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m3r8m851ad.fsf@venus.fo.et.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 25 Mar 2002 12:53:12 +0100
Message-Id: <1017057192.22083.4.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le lun 25-03-2002 à 12:34, Joachim Breuer a écrit :
> Being able to redetect a pulled card put in a different slot as a
> "known" one giving it the same eth<i> (and associated WOL etc. config)
> as before would of course be nice, but I can't see how this can be
> cleanly done over reboots.

Some may say that being able to give the same eth<i> to the same bus
position, even after swapping the card for a new one, is more important
- think of production machines which can't afford being off-service for
too long. You just shutdown, swap the cards, poweron and you go. No
reconfig, that's how it should run.

	Xav


