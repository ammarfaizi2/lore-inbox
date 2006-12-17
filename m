Return-Path: <linux-kernel-owner+w=401wt.eu-S1752672AbWLQOHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbWLQOHl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 09:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbWLQOHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 09:07:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:12187 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbWLQOHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 09:07:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=Sr1TFZI8XrWs5iUWRdbGkGkBFo5US8BQ5WODyuVuCTmIbuYRKlMQvFCWA6Xytf3+N51oGF1rp4guJBiMeUck5PIOTQPqWMXrpwBSOaVCS4+2XG3Vuhni1Qz3kdkc3iP3HOjk++ajgm8AgAlBpzHWwuczw5M3JaulpywziJW0YgE=
Message-ID: <45854F1F.5080201@gmail.com>
Date: Sun, 17 Dec 2006 15:07:04 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Neil Brown <neilb@suse.de>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       Tejun Heo <htejun@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>,
       Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
References: <20061204203410.6152efec.akpm@osdl.org> <200612161056.26830.rjw@sisk.pl> <200612161216.07669.rjw@sisk.pl> <200612171200.13075.rjw@sisk.pl>
In-Reply-To: <200612171200.13075.rjw@sisk.pl>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Okay, I have identified the patch that causes the problem to appear, which is
> 
> fix-sense-key-medium-error-processing-and-retry.patch
> 
> With this patch reverted -rc1-mm1 is happily running on my test box.

Yes! Here too. Good work.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
