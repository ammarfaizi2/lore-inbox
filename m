Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWFKQCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWFKQCs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 12:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWFKQCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 12:02:48 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:39698 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751637AbWFKQCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 12:02:47 -0400
Date: Sun, 11 Jun 2006 18:02:44 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060611160243.GH20700@vanheusden.com>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060610222734.GZ27502@mea-ext.zmailer.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Jun  8 11:47:54 CEST 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm.
What about using spamhaus.org sbl+xbl list?
I used to receive 1200 spam messages a day, with spamhaus only half of
that.

On Sun, Jun 11, 2006 at 01:27:34AM +0300, Matti Aarnio wrote:
> Now that there is even an RFC published about SPF...
> 
> 
> What is SPF ?
> 
> It is one way to to ensure that at SMTP transport level the claimed
> message source domain is valid, and message is coming from place
> where origination domain's administrator has declared that are valid
> source servers for emails claiming to be of that domain.
> 
> 
> It does NOT verify that SMTP origination local part is true. 
> 
> It does NOT verify message visible headers.
> 
> Several people have written MTA configurations that test arriving email
> visible "From:" (and sometimes "Sent:") header against SPF data and
> actually violate SPF specification doing that!
> (We have routinely kicked subscribers with that bug from lists..)
> 
> 
> What it gives ?
> 
> It gives us a way to tell the world, that emails claiming to be
> coming from VGER should be accepted only when they really are
> coming from vger. (Complications like recipients incoming MX
> relays are not _our_ problem..)
> 
> We might get slight reduction of back falling junk at vger with
> that - reduction increases when people begin to deploy the SPF
> verification more and more widely into their receiving email servers.
> (And do it correctly...)
> 
> 
> 
> Will VGER begin to verify SPF in incoming email ?
> 
> Yes, sometime this summer.
> 
> 
> 
> What will break ?
> 
> You really should go and read SPF documents and guides and FAQs at:
>     http://spf.pobox.com/
> 
> Very little will break, but one should really consider converting
> their email sending methodology to one, which uses fewest possible
> number of servers, publish that data in DNS, and always send all
> emails thru those servers.
> 
> In longer run the amount of irresponsible (incurable) network security
> holes (known as Windows) shows no sign of becoming extinct at adsl -lines,
> so there will be increased pressure to demand sender identification
> (and verification) during email sending - viruses can't do that yet...
> And when they learn, user with infection can be trivially identified
> and contacted/blocked.  At the same time I do find it most likely that
> ADSL-lines (and modems) will no longer be allowed to send _anywhere_
> over plain SMTP.
> 
> In order to be able to send email, a "SUBMISSION" protocol does exist,
> and is relatively easy to get working with for example the Thunderbird.
> Better would be having a button "use submission service" in its account
> setup..   (And similar in Outlook/O.Express...)
> 
> 
> /Matti Aarnio -- one of  postmaster at vger.kernel.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
