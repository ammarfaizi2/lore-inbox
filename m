Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965385AbWJBTlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965385AbWJBTlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965386AbWJBTlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:41:55 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:44784 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S965385AbWJBTly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:41:54 -0400
Date: Mon, 2 Oct 2006 12:41:06 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Dan Williams <dcbw@redhat.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002194106.GB14966@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <20061002113259.GA8295@gamma.logic.tuwien.ac.at> <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com> <20061002124613.GB13984@gamma.logic.tuwien.ac.at> <20061002165053.GA2986@gamma.logic.tuwien.ac.at> <1159808304.2834.89.camel@localhost.localdomain> <20061002111537.baa077d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002111537.baa077d2.akpm@osdl.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 11:15:37AM -0700, Andrew Morton wrote:
> 
> Jean, John: the amount of trouble which this change is causing is quite
> high considering that we're not even at -rc1 yet.  It's going to get worse.
> 
> It doesn't sound like it'll be too hard to arrange for the kernel to
> continue to work correctly with old userspace?

	Actually, I have the perfect solution. We ship a new version
of the Wireless Tools and wpa_supplicant alongside the kernel, and
install those when the user install the new kernel. That way, we make
sure they always use the correct version of userspace with the kernel.
	Regards,

	Jean

