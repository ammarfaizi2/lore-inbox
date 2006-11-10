Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946033AbWKJWyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946033AbWKJWyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 17:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946221AbWKJWyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 17:54:19 -0500
Received: from mail.syneticon.net ([213.239.212.131]:31634 "EHLO
	mail2.syneticon.net") by vger.kernel.org with ESMTP
	id S1946033AbWKJWyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 17:54:18 -0500
Message-ID: <45550308.1090408@wpkg.org>
Date: Fri, 10 Nov 2006 23:54:00 +0100
From: Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, madduck@madduck.net
Subject: Re: scary messages: HSM violation during boot of 2.6.18/amd64
References: <455496CA.5040405@wpkg.org> <200611102239.kAAMdoYV015817@turing-police.cc.vt.edu>
In-Reply-To: <200611102239.kAAMdoYV015817@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

(...)

> And I *am* passing '-d ata' - /etc/smartd.conf contains:
> 
> /dev/sda -a -d ata -o on -S on -m root -l error -l selftest -s (S/../.././(00|06|12|18)|L/../.././03|O/../.././.[02468])
> 
> (Testing with removing '-d ata' results in smartd saying it can't talk to the
> scsi device at /dev/sda).
> 
> Any ideas/suggestions?

You use old smartmontools :)

-o on / -S on is not supported for sata, unless you use a CVS version of 
smartmontools.

For more info, check smartmontools-support mailing list.


-- 
Tomasz Chmielewski

http://wpkg.org

