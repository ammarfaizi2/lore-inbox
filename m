Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWJCQyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWJCQyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWJCQyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:54:39 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:30963 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932272AbWJCQyi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:54:38 -0400
Date: Tue, 3 Oct 2006 09:52:14 -0700
To: Theodore Tso <tytso@mit.edu>, "John W. Linville" <linville@tuxdriver.com>,
       Dan Williams <dcbw@redhat.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>, Norbert Preining <preining@logic.at>,
       hostap@shmoo.com, linux-kernel@vger.kernel.org,
       ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003165214.GD17252@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org> <5a4c581d0610021508hdc331f0w7c9b71c3944d4d8b@mail.gmail.com> <1159877574.2879.11.camel@localhost.localdomain> <20061003124902.GB23912@tuxdriver.com> <20061003133845.GG2930@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003133845.GG2930@thunk.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 09:38:45AM -0400, Theodore Tso wrote:
> 
> John, has the wireless community considered creating a new interface
> which *is* carefully designed, and supporting both the new and the
> legacy interface for 2-3 years until all of the mainstream
> distributions have had a chance to cycle?  It would be hard, I know,
> but would it be harder than some of the alternatives, and would it be
> worth it?

	No API is guaranteed to be stable forever. And I think the
overall track record of stability for the Wireless Extensions is
pretty good.
	On top of that, the tools themselves *WARNS YOU* when there is
an API incompatibility, giving the user the change to correct the
issue. There is not many API having such feature...

	In my mind, the whole point of the GIT and RC process is to
test changes before setting them in stone, so that we have the time to
correct our mistakes. I definitely think the process is working
properly.
	If you think I jumped the gun, consider that both FC and
Mandriva which have the right userspace bits are in RC phase
(FC6-test3 and 2007-rc2), and therefore will ship about the same time
2.6.19 hits final. And Debian with the right userspace bits is
supposed to be released in december (no comment).

> Regards,
> 
> 						- Ted

	Have fun...

	Jean
