Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269522AbTGJSWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbTGJSWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:22:51 -0400
Received: from intra.cyclades.com ([64.186.161.6]:14992 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S269523AbTGJSWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:22:32 -0400
Message-ID: <003101c34712$a9b8f480$602fa8c0@henrique>
From: "Henrique Oliveira" <henrique2.gobbi@cyclades.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Kevin Curtis" <kevin.curtis@farsite.co.uk>
Cc: "lkml" <linux-kernel@vger.kernel.org>
References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk> <Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
Date: Thu, 10 Jul 2003 11:39:57 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The patch for the generic HDLC layer was included on the kernel 2.4.21. Thus
this layer is already on the main tree (unless, of course, someone has
removed it, I havent checked 2.4.22 yet). This layer provides data link
protocol (ppp, hdlc, raw-hdlc, x25, frame-relay, cisco-hdlc) for the kernel.
It's mainly used by synchronous cards drivers (Cyclades, Moxa, SDL, Farsite,
etc, etc, etc).
regards
Henrique

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
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

