Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265110AbSJWR7K>; Wed, 23 Oct 2002 13:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSJWR7K>; Wed, 23 Oct 2002 13:59:10 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:25836 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265110AbSJWR7J>;
	Wed, 23 Oct 2002 13:59:09 -0400
Date: Wed, 23 Oct 2002 19:07:16 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ashwin Sawant <sawant_ashwin@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Workqueues and the Nvidia driver
Message-ID: <20021023180716.GA3319@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ashwin Sawant <sawant_ashwin@rediffmail.com>,
	linux-kernel@vger.kernel.org
References: <20021023175255.547.qmail@webmail30.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023175255.547.qmail@webmail30.rediffmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 05:52:55PM -0000, Ashwin  Sawant wrote:
 > I have successfully compiled the latest Nvidia driver with kernel 
 > 2.5.44 on a heavily modified RH 7.2 (original compiler) box  after 
 > applying the patch posted to this list previously. However it 
 > can't be loaded because insmod bombs out saying that, IIRC, 
 > create_workqueue, flush_workqueue, and a couple of other similar 
 > symbols are unresolved.

These symbols are exported only to modules with a GPL license.
The nVidia driver does not meet this criteria.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
