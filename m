Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWGaVzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWGaVzE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWGaVzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:55:04 -0400
Received: from mail.gmx.net ([213.165.64.21]:44772 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751366AbWGaVzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:55:02 -0400
X-Authenticated: #428038
Message-ID: <44CE7C31.5090402@gmx.de>
Date: Mon, 31 Jul 2006 23:54:57 +0200
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060725 SUSE/1.0.3-0 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Ulrich <reiser4@blinkenlights.ch>
CC: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>	<200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl> <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
In-Reply-To: <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=052E7D95;
	url=http://home.pages.de/~mandree/keys/GPGKEY.asc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Ulrich wrote:

> See also: http://spam.workaround.ch/dull/postmark.txt
> 
> A quick'n'dirty ZFS-vs-UFS-vs-Reiser3-vs-Reiser4-vs-Ext3 'benchmark'

Whatever Postmark does, this looks pretty besides the point.

Are these actual transactions with the "D"urability guarantee?
3000/s doesn't look too much like you're doing synchronous I/O (else
figures around 70/s perhaps 100/s would be more adequate), and cache
exercise is rather irrelevant for databases that manage real (=valuable)
data...

-- 
Matthias Andree
