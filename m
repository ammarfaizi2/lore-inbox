Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269820AbTGKIRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269818AbTGKIRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:17:48 -0400
Received: from relay5.ftech.net ([195.200.0.100]:21960 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id S269820AbTGKIPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:15:21 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E25C97A@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: "'Henrique Oliveira'" <henrique2.gobbi@cyclades.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Kevin Curtis <kevin.curtis@farsite.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
Date: Fri, 11 Jul 2003 09:30:00 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies, it is already there in 2.4.21, however I have been monitoring
the change logs, and I can't see it mentioned there anywhere.

Thanks very much for pointing this out.


Kevin

-----Original Message-----
From: Henrique Oliveira [mailto:henrique2.gobbi@cyclades.com] 
Sent: 10 July 2003 19:40
To: Marcelo Tosatti; Kevin Curtis
Cc: lkml
Subject: Re: Why is generic hldc beig ignored? RE:Linux 2.4.22-pre4


Hi,
The patch for the generic HDLC layer was included on the kernel 2.4.21. Thus
this layer is already on the main tree (unless, of course, someone has
removed it, I havent checked 2.4.22 yet). This layer provides data link
protocol (ppp, hdlc, raw-hdlc, x25, frame-relay, cisco-hdlc) for the kernel.
It's mainly used by synchronous cards drivers (Cyclades, Moxa, SDL, Farsite,
etc, etc, etc). regards Henrique

----- Original Message -----
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Kevin Curtis" <kevin.curtis@farsite.co.uk>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Thursday, July 10, 2003 10:11 AM
Subject: Re: Why is generic hldc beig ignored? RE:Linux 2.4.22-pre4


>
>
> On Thu, 10 Jul 2003, Kevin Curtis wrote:
>
> > The usual request for generic hdlc (please).
> > Why are requests for it's inclusion being ignored?
> >
> >
> > Kevin Curtis
> > Linux Development
> > FarSite Communications Ltd
> > www.farsite.co.uk
> > tel:  +44 1256 330461
> > fax:  +44 1256 854931
>
>
> Where is the patch and why do you want it in?
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to majordomo@vger.kernel.org 
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
