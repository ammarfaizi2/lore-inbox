Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWHRP61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWHRP61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWHRP61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:58:27 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:60074 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932474AbWHRP6Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:58:25 -0400
In-Reply-To: <20060818151340.GB27947@krispykreme>
Subject: Re: [2.6.19 PATCH 2/7] ehea: pHYP interface
To: Anton Blanchard <anton@samba.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       netdev@vger.kernel.org, ossthema@de.ibm.com,
       Thomas Q Klein <tklein@de.ibm.com>, tklein@linux.ibm.com
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OFF0CF1858.B1C22ED6-ONC12571CE.0056FB13-C12571CE.0057BEA6@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 18 Aug 2006 18:02:17 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 18/08/2006 18:02:16
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Hi,
>
> > I asked SO to recount arguments and we've come to a conclusion that
> > there're in fact 19 args not 18 as the name suggests. 19 args is
> > I-N-S-A-N-E.
>
> It will be partially cleaned up by:
>
> http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024556.html
>
> However it doesnt fix the fact someone has architected such a crazy
> interface :(
>
> Anton


well, just as background info, this is the wrapper around
a single assembly instruction which calls system firmware and takes
9 CPU registers for input and 9 CPU registers for output parameters.
This definition by platform architecture won't change in the near future,
but the good news is with Antons change the wrapper will look much nicer.

Gruss / Regards . . . Christoph R

