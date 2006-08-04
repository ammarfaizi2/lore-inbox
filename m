Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWHDLUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWHDLUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 07:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWHDLUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 07:20:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49795
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932403AbWHDLUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 07:20:20 -0400
Date: Fri, 04 Aug 2006 04:20:24 -0700 (PDT)
Message-Id: <20060804.042024.63108922.davem@davemloft.net>
To: molle.bestefich@gmail.com
Cc: auke-jan.h.kok@intel.com, charlieb@budge.apana.org.au,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: e100: checksum mismatch on 82551ER rev10
From: David Miller <davem@davemloft.net>
In-Reply-To: <62b0912f0608040404p59545a0asc7f5fc5f537ec32c@mail.gmail.com>
References: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com>
	<44D0D7CA.2060001@intel.com>
	<62b0912f0608040404p59545a0asc7f5fc5f537ec32c@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Molle Bestefich" <molle.bestefich@gmail.com>
Date: Fri, 4 Aug 2006 13:04:07 +0200

> You're trying to pull Linux end users into a war between Intel and
> it's vendors, so you can make end users scream at the vendors when
> they forget to run the checksum tool.

I totally agree, Intel driver maintainers generally act like complete
idiots in these kinds of situations.

If the EEPROM has a broken checksum, the user should have an option
that allows him to try and use the device anyways, end of story.

It is only self serving to not provide this option to the user.

People make errors, EEPROM's get shipped with bad checksums but the
device might still be usable.  That is life get over it.
