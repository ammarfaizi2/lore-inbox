Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946877AbWKANyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946877AbWKANyy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946881AbWKANyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:54:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8356 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946877AbWKANyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:54:53 -0500
Subject: Re: [PATCH v2] Re: Battery class driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Richard Hughes <hughsient@gmail.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Jean Delvare <khali@linux-fr.org>, davidz@redhat.com,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>
In-Reply-To: <1162387577.5001.7.camel@hughsie-laptop>
References: <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com>
	 <6DP6m926.1162281579.9733640.khali@localhost>
	 <41840b750610310542u2bbcf4b6y5f9f812ebd12445@mail.gmail.com>
	 <1162302686.31012.47.camel@frg-rhel40-em64t-03>
	 <41840b750610310606t2b21d277k724f868cb296d17f@mail.gmail.com>
	 <1162387577.5001.7.camel@hughsie-laptop>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:54:20 +0800
Message-Id: <1162389260.18406.62.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 13:26 +0000, Richard Hughes wrote:
> With the battery class driver, how would that be conveyed? Would the
> sysfs file be deleted in this case, or would the value of the sysfs
> key be something like "<invalid>". 

I'd be inclined to make the read return -EINVAL.

-- 
dwmw2

