Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266054AbUGEL73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266054AbUGEL73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 07:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbUGEL73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 07:59:29 -0400
Received: from webmail-benelux.tiscali.be ([62.235.14.106]:49502 "EHLO
	mail.tiscali.be") by vger.kernel.org with ESMTP id S266054AbUGEL71 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 07:59:27 -0400
Date: Mon, 5 Jul 2004 13:59:21 +0200
Message-ID: <40BD9F8700015B8E@ocpmta2.freegates.net>
In-Reply-To: <20040705051010.GA24583@nevyn.them.org>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
To: "Daniel Jacobowitz" <dan@debian.org>, "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

> > So just use
> > 
> > 	buffer++;
> > 
> > here, and the intent is then clear.
> 
> Except C does not actually allow incrementing a void pointer, since
> void does not have a size.
That make better sense to me because aifair a void * was foreseen to pass
any kind of type * as actual parameter?
(So as far as I understand, the aritthm pointer sould be dynamic for the
best 'natural' behaviour?)

>   You can't do arithmetic on one either.  GNU
> C allows this as an extension.
> 
> It's actually this, IIRC:
>   buffer = ((char *) buffer) + 1;
> 
Many thanks,
    Joel


---------------------------------------------------------------------------
Tiscali ADSL LIGHT, 19,95 EUR/mois pendant 6 mois, c'est le moment de faire
le pas!
http://reg.tiscali.be/default.asp?lg=fr




