Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbSKSRY1>; Tue, 19 Nov 2002 12:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSKSRY1>; Tue, 19 Nov 2002 12:24:27 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6633 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266917AbSKSRY0>;
	Tue, 19 Nov 2002 12:24:26 -0500
Date: Tue, 19 Nov 2002 17:29:41 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Ducrot Bruno <poup@poupinou.org>
Cc: Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021119172941.GB4176@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ducrot Bruno <poup@poupinou.org>,
	Margit Schubert-While <margit@margit.com>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119142731.GF27595@poup.poupinou.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:27:31PM +0100, Ducrot Bruno wrote:
 > > The newer ACPI code also introduces problems that aren't
 > > present with the current 2.4.20rc code.
 > I disagree with you.  It introduces more enhancements,
 > and more bugfix than the current code.  I admit that tt
 > could introduce some news bugs, but in the balance it
 > should be more stable than before.
 > Really, I will be happy to see new code in mainstream.

In fact, the problem with my Vaio happens due to the changes
_already_ in 2.4.20pre. I'm now backing them out to try and
isolate the exact changes that caused the problem.

This is exactly the sort of thing I meant. The ACPI stuff is
so fragile a few tiny changes makes a box unbootable.
Merging nearly 3MB of changes at this stage would be lunacy.
Save it for .20pre

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
