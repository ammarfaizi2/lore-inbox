Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWGaGGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWGaGGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWGaGGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:06:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:947 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932117AbWGaGGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:06:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MGjLA4jybObixkWRh5XdqvID24j+32G1GHrTkVYWorG5c+M5BegNt5gDAay4ZwDrEZItAVAJCg+MrJx3aFrYcsdTCY7gzOFojFEcontmmTEeRS09lO0ohS/S8Cgr/6iRuPSA6Ybqh7G0B0PiwYs7IJ1y0YMOTUFH9YdaqNmudrM=
Message-ID: <9e0cf0bf0607302306g435d73a1qbdab334c318c8dc2@mail.gmail.com>
Date: Mon, 31 Jul 2006 09:06:43 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Kasper Sandberg" <lkml@metanurb.dk>
Subject: Re: ipw3945 status
Cc: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>,
       "Pavel Machek" <pavel@suse.cz>, "Theodore Tso" <tytso@mit.edu>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>, "Jan Dittmer" <jdi@l4x.org>,
       "Jirka Lenost Benc" <jbenc@suse.cz>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
In-Reply-To: <1154308614.13635.49.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060730104042.GE1920@elf.ucw.cz>
	 <20060730145305.GE23279@thunk.org> <20060730231251.GB1800@elf.ucw.cz>
	 <200607310123.06177.s0348365@sms.ed.ac.uk>
	 <1154308614.13635.49.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Kasper Sandberg <lkml@metanurb.dk> wrote:
> I entirely agree that this should not be merged, those will accept these
> kindof things, can use intels out of tree driver.
>
> i sincerely hope for a forked/rewritten driver which does not depend on
> closed userspace daemons.

I personally think that this also violates the GPL license...
The GPL part cannot stand by it-self and require none GPLed component
in order to make it work.

The fact that the regularity daemon work using external sysfs
interface without linkage requirements does not escape derived work in
this case.

Best Regards,
Alon Bar-Lev
