Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030433AbWHUMzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030433AbWHUMzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHUMzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:55:52 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61427 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932092AbWHUMzv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:55:51 -0400
In-Reply-To: <1156164265.9855.196633.camel@hal.voltaire.com>
Subject: Re: [openib-general] [PATCH 08/13] IB/ehca: qp
To: Hal Rosenstock <halr@voltaire.com>
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
       openib-general@openib.org, Roland Dreier <rolandd@cisco.com>
X-Mailer: Lotus Notes Release 7.0 HF242 April 21, 2006
Message-ID: <OFD6EEAEDC.E8A6DA73-ONC12571D1.0046AAD5-C12571D1.0047061E@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Mon, 21 Aug 2006 14:59:39 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 21/08/2006 14:59:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I, for one, was hoping that the timer based transition to active for QP1
> would have been resolved before being submitted. Any idea on the plan to
> resolve this ?
>
> -- Hal
>
>
>
We're testing it. As I mentioned before, this requires a change in the
system firmware. I personally don't think this will show up in firmware in
time for 2.6.19 merge window.
So unfortunately we still need that loop.

Regards . . . Christoph R


