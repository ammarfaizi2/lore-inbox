Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbRHALru>; Wed, 1 Aug 2001 07:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266864AbRHALrm>; Wed, 1 Aug 2001 07:47:42 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:40142 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S266806AbRHALrg>; Wed, 1 Aug 2001 07:47:36 -0400
Date: Wed, 1 Aug 2001 13:49:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Arjan van de Ven <arjanv@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <3B67CE6A.A670093E@redhat.com>
Message-ID: <Pine.GSO.3.96.1010801134415.19537C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Arjan van de Ven wrote:

> Oh it is. And it's due to a recommendation Intel makes to bios writers. 
> As a result, every P4 I've encountered shares this bug. Intel knows it's
> an invalid MP table, but refuses to change the recommendation.

 Where's the recommendation?  We might work it around somehow. 

 Alternatively we may just disable the SMP mode if the bootstrap CPU's
real ID contradits the one in the MP table. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

