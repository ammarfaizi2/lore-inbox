Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317978AbSIJSjw>; Tue, 10 Sep 2002 14:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSIJSjF>; Tue, 10 Sep 2002 14:39:05 -0400
Received: from nameservices.net ([208.234.25.16]:33987 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S317978AbSIJSi7>;
	Tue, 10 Sep 2002 14:38:59 -0400
Message-ID: <3D7E3E1D.3A9C3246@opersys.com>
Date: Tue, 10 Sep 2002 14:46:53 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] 1/8 LTT for 2.5.34: Core infrastructure
References: <3D7E36E2.625141D6@opersys.com> <20020910204041.A2197@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sam Ravnborg wrote:
> On Tue, Sep 10, 2002 at 02:16:02PM -0400, Karim Yaghmour wrote:
> > +ifdef CONFIG_TRACE
> > +obj-y += trace.o
> >  endif
> This is still bogus.
> The day that CONFIG_TRACE equals n you will still include trace.o.
> An explicit test for m or y is preferable.

Thanks, I will make the appropriate changes.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
