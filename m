Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTJGH4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 03:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTJGH4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 03:56:55 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:29861 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S261875AbTJGH4y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 03:56:54 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01EF1308@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: Jamie Lokier <jamie@shareable.org>, bert hubert <ahu@ds9a.nl>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: Futex
Date: Tue, 7 Oct 2003 09:56:52 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, as part of the kernel, I guess we could add an updated ascii version.

Regards,
Fabian


-----Message d'origine-----
De : Jamie Lokier [mailto:jamie@shareable.org]
Envoyé : lundi 6 octobre 2003 19:12
À : bert hubert; Frederick, Fabian; Linux-Kernel (E-mail)
Objet : Re: Futex


bert hubert wrote:
> On Mon, Oct 06, 2003 at 09:22:19AM +0200, Frederick, Fabian wrote:
> > Hi,
> > 
> > 	Why don't we have any futex doc included ?
> > Nothing about futexfs nor userspace futex usage ....
> 
> http://ds9a.nl/futex-manpages/

Those docs are a little out of date and incomplete, though.

There's no mention of FUTEX_REQUEUE, and no mention of the important
token-passing property: that the value returned from FUTEX_WAKE is
equal to the number of calls which return 0 from FUTEX_WAIT.
(Only when FUTEX_FD is not used; FUTEX_FD is broken with respect to
token passing at the moment).

-- Jamie
