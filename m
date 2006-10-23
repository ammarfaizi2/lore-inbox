Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWJWUKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWJWUKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWJWUKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:10:38 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:62995 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030188AbWJWUKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:10:36 -0400
To: Richard Hughes <hughsient@gmail.com>
Cc: Dan Williams <dcbw@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
Subject: Re: Battery class driver.
X-Message-Flag: Warning: May contain useful information
References: <1161628327.19446.391.camel@pmac.infradead.org>
	<1161631091.16366.0.camel@localhost.localdomain>
	<1161633509.4994.16.camel@hughsie-laptop>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 23 Oct 2006 13:10:25 -0700
In-Reply-To: <1161633509.4994.16.camel@hughsie-laptop> (Richard Hughes's message of "Mon, 23 Oct 2006 20:58:29 +0100")
Message-ID: <adairiaeqtq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Oct 2006 20:10:26.0321 (UTC) FILETIME=[476EA010:01C6F6DF]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > No, I think the distinction between batteries and ac_adapter is large
 > enough to have different classes of devices. You may have many
 > batteries, but you'll only ever have one ac_adapter. I'm not sure it's
 > an obvious abstraction to make.

Speaking from ignorance here, but what about (big) systems that have
multiple power supplies and multiple rails of AC power?  Would it make
sense to use the same abstraction for that as well as laptop AC adaptors?
