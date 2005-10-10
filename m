Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVJJWsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVJJWsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVJJWsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:48:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62945 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbVJJWsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:48:01 -0400
Date: Mon, 10 Oct 2005 15:47:31 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Harald Welte <laforge@gnumonks.org>, Chris Wright <chrisw@osdl.org>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, security@linux.kernel.org,
       vendor-sec@lst.de
Subject: Re: [BUG/PATCH/RFC] Oops while completing async USB via usbdevio
Message-ID: <20051010224731.GW5856@shell0.pdx.osdl.net>
References: <20050927165206.GB20466@master.mivlgu.local> <Pine.LNX.4.58.0509270959380.3308@g5.osdl.org> <20050930104749.GN4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509300752530.3378@g5.osdl.org> <20050930184433.GF16352@shell0.pdx.osdl.net> <Pine.LNX.4.64.0509301225190.3378@g5.osdl.org> <20050930220808.GE4168@sunbeam.de.gnumonks.org> <Pine.LNX.4.64.0509301514190.3378@g5.osdl.org> <20051010174429.GH5627@rama> <Pine.LNX.4.64.0510101052520.14597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510101052520.14597@g5.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> Yes, looks ok, apart from some small details. Like "uid" adn "euid" is of 
> type "uid_t", not "pid_t", and I think that "kill_proc_info_as_uid()" 
> needs exporting for modules (I assume usbdevio can be one).
> 
> Chris, others, comments?

Agree with above, but I hope it could be considered a temporary interface.

thanks,
-chris
