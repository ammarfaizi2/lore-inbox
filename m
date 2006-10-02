Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWJBVIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWJBVIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWJBVIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:08:48 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:63994 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S965121AbWJBVIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:08:46 -0400
Date: Mon, 2 Oct 2006 14:04:06 -0700
To: Dan Williams <dcbw@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002210406.GA15140@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <20061002113259.GA8295@gamma.logic.tuwien.ac.at> <5a4c581d0610020521q721e3157q88ad17d3cc84a066@mail.gmail.com> <20061002124613.GB13984@gamma.logic.tuwien.ac.at> <20061002165053.GA2986@gamma.logic.tuwien.ac.at> <1159808304.2834.89.camel@localhost.localdomain> <20061002111537.baa077d2.akpm@osdl.org> <20061002194106.GB14966@bougret.hpl.hp.com> <1159822657.11771.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159822657.11771.1.camel@localhost.localdomain>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 04:57:37PM -0400, Dan Williams wrote:
> On Mon, 2006-10-02 at 12:41 -0700, Jean Tourrilhes wrote:
> > 
> > 	Actually, I have the perfect solution. We ship a new version
> > of the Wireless Tools and wpa_supplicant alongside the kernel, and
> > install those when the user install the new kernel. That way, we make
> > sure they always use the correct version of userspace with the kernel.
> 
> Like udev :)  And libsysfs :)

	Wait, wait, this starts to look too much like *BSD ;-)

	Jean
