Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWJCDCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWJCDCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 23:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWJCDC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 23:02:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23960 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWJCDC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 23:02:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ktYIG1W4/ZY90qIv5iKeotkY3waa4uCAVih4Bil5eheUSjfxrWGzFamHEoyKQgt87TfNvTthq+Sz7RfXbLCuHDxQfBkN9BGQQBhKxv9fGEmhrNnP0tE3XRRGhRbzdwTwSH6/DsG6jOS6cmLgAiV6pw+OFg9ISZm278sBKVQVZEU=
Message-ID: <41840b750610022002j4d73ab23l83a88ec757925b08@mail.gmail.com>
Date: Tue, 3 Oct 2006 05:02:25 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: SATA status reports update
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       "Pavel Machek" <pavel@suse.cz>, "Tejun Heo" <htejun@gmail.com>
In-Reply-To: <451CE8EC.1020203@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <451CE8EC.1020203@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 9/29/06, Jeff Garzik <jeff@garzik.org> wrote:
> Software status:
>         http://linux-ata.org/software-status.html

It says:
"Over and above the power management specified in the ATA/ATAPI
specification, one can aggressively control the power consumption of
SATA hosts, the SATA bus, and the SATA device. [...]
There is little demand at the present time for aggressive, automatic
power management under Linux."


What about laptops on batteries? Pavel reports a 1W power draw by his
ThinkPad's ICH7M SATA controller [1]. It would be neat to eliminate
this when the disk is not in use (and powering up the silicon can't
take much longer than spinning up a chunk glass to 7200RPM).

  Shem

[1] http://atrey.karlin.mff.cuni.cz/~pavel/swsusp/8hours.pdf
    slide 11
