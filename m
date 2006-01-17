Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWAQOK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWAQOK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWAQOK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:10:26 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:53937 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S932505AbWAQOKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:10:25 -0500
Date: Tue, 17 Jan 2006 15:10:19 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060117141019.GA32232@uio.no>
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43CCA80B.4020603@tls.msk.ru>
X-Operating-System: Linux 2.6.14.3 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
X-Spam-Score: -0.0 (/)
X-Spam-Report: Status=No hits=-0.0 required=5.0 tests=NO_RELAYS version=3.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 11:17:15AM +0300, Michael Tokarev wrote:
> Neil, is this online resizing/reshaping really needed?  I understand
> all those words means alot for marketing persons - zero downtime,
> online resizing etc, but it is much safer and easier to do that stuff
> 'offline', on an inactive array, like raidreconf does - safer, easier,
> faster, and one have more possibilities for more complex changes. 

Try the scenario where the resize takes a week, and you don't have enough
spare disks to move it onto another server -- besides, that would take
several days alone... This is the kind of use-case for which I wrote the
original patch, and I'm grateful that Neil has picked it up again so we can
finally get something working in.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
