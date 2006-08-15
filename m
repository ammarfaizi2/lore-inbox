Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWHOLDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWHOLDX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 07:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHOLDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 07:03:23 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:30662 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030218AbWHOLDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 07:03:22 -0400
In-Reply-To: <35786B99AB3FDC45A821572461791973AC87D3@gbrwgceumf01.eu.xerox.net>
Subject: RE: [PATCH 4/6] ehea: header files
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       michael@ellerman.id.au, "netdev" <netdev@vger.kernel.org>,
       ossthema@de.ibm.com, Thomas Q Klein <tklein@de.ibm.com>
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OF8C6BA147.30EE53F8-ONC12571CB.003C7748-C12571CB.003CBAA4@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 15 Aug 2006 13:07:08 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 15/08/2006 13:07:08
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Jenkins, Clive" wrote on 15.08.2006 12:53:05:

> > > You mean the eHEA has its own concept of page size? Separate from
> the
> > > page size used by the MMU?
> > >
> >
> > yes, the eHEA currently supports only 4K pages for queues
>
> In that case, I suggest use the kernel's page size, but add a
> compile-time
> check, and quit with an error message if driver does not support it.

eHEA does support other page sizes than 4k, but the HW interface expects to
see 4k pages
The adaption is done in the device driver, therefore we have a seperate 4k
define.


Regards . . . Christoph R.

