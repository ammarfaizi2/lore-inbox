Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWJBU6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWJBU6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWJBU6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:58:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51131 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965008AbWJBU6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:58:35 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Dan Williams <dcbw@redhat.com>
To: jt@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
In-Reply-To: <20061002194106.GB14966@bougret.hpl.hp.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
	 <20061002113259.GA8295@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com>
	 <20061002124613.GB13984@gamma.logic.tuwien.ac.at>
	 <20061002165053.GA2986@gamma.logic.tuwien.ac.at>
	 <1159808304.2834.89.camel@localhost.localdomain>
	 <20061002111537.baa077d2.akpm@osdl.org>
	 <20061002194106.GB14966@bougret.hpl.hp.com>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 16:57:37 -0400
Message-Id: <1159822657.11771.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 12:41 -0700, Jean Tourrilhes wrote:
> On Mon, Oct 02, 2006 at 11:15:37AM -0700, Andrew Morton wrote:
> > 
> > Jean, John: the amount of trouble which this change is causing is quite
> > high considering that we're not even at -rc1 yet.  It's going to get worse.
> > 
> > It doesn't sound like it'll be too hard to arrange for the kernel to
> > continue to work correctly with old userspace?
> 
> 	Actually, I have the perfect solution. We ship a new version
> of the Wireless Tools and wpa_supplicant alongside the kernel, and
> install those when the user install the new kernel. That way, we make
> sure they always use the correct version of userspace with the kernel.

Like udev :)  And libsysfs :)

> 	Regards,
> 
> 	Jean
> 

