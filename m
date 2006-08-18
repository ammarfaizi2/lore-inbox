Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWHRPjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWHRPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbWHRPjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:39:24 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:38983 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161015AbWHRPjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:39:23 -0400
In-Reply-To: <200608180134.39050.arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 13/13] IB/ehca: makefiles/kconfig
To: abergman@de.ibm.com
Cc: Christoph Raisch <RAISCH@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       openib-general@openib.org, Roland Dreier <rolandd@cisco.com>
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OFC07EB1C7.B6C18CC5-ONC12571CE.0056110B-C12571CE.0055FF7C@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Fri, 18 Aug 2006 17:43:13 +0200
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 18/08/2006 17:43:15
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


abergman@de.ltcfwd.linux.ibm.com wrote on 18.08.2006 01:34:37:

> On Thursday 17 August 2006 22:11, Roland Dreier wrote:
> > +
> > +CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
>
> This seems really pointless, since you're always defining these
> macros to the same value.
>
> Just drop the CFLAGS and remove the code that depends on them
> being different.
Yes, that's true. Those defines are unnecessary. We'll throw them out.
Thx
Hoang-Nam Nguyen

