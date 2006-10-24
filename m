Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWJXDoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWJXDoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 23:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWJXDoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 23:44:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:30927 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030202AbWJXDod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 23:44:33 -0400
Subject: Re: Battery class driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, David Zeuthen <davidz@redhat.com>
In-Reply-To: <1161636514.27622.30.camel@shinybook.infradead.org>
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 13:44:15 +1000
Message-Id: <1161661455.10524.545.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It makes _less_ sense, imho, to have 'ac present' as a property of a
> battery -- which is what I've done for now.

Then maybe it's better to call it "in_use" meaning that the system is
currently drawing power from that battery rather than "ac_present"...

Ben.


