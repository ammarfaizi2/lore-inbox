Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTEFHPr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTEFHPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:15:47 -0400
Received: from elin.scali.no ([62.70.89.10]:35981 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262423AbTEFHPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:15:45 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: D.A.Fedorov@inp.nsk.su
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SGI.4.10.10305060920320.7773473-100000@Sky.inp.nsk.su>
References: <Pine.SGI.4.10.10305060920320.7773473-100000@Sky.inp.nsk.su>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052206053.15887.0.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 May 2003 09:27:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, but it should be enough


On Tue, 2003-05-06 at 04:23, Dmitry A. Fedorov wrote:
> On 6 May 2003, Terje Eggestad wrote:
> 
> > Good point, it should actually be very simple.
> > from /proc/ksyms we've got teh adresses of the sys_*, then from
> > asm/unistd.h we got the order.
> 
> /proc/ksyms shows only exported symbols, is not it?
> 
> > Then search thru /dev/kmem until you find the right string og addresses,
> > and you got sys_call_table. 
> > 
> > Dirty but it should be portable. 
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

