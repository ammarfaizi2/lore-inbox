Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbVIOSYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbVIOSYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbVIOSYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:24:16 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:58580 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030564AbVIOSYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:24:15 -0400
Message-ID: <4329BC43.7030406@v.loewis.de>
Date: Thu, 15 Sep 2005 20:24:03 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4B2ZV-2dl-7@gated-at.bofh.it> <4HKbZ-Cx-37@gated-at.bofh.it>
In-Reply-To: <4HKbZ-Cx-37@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> BOM should not be used in UTF-8.  In fact, it shouldn't be used at
> all.

Says who? In UTF-8, it is not used to indicate a byte order; instead,
it is used to indicate the fact that the file is UTF-8, like a magic.
That's why I prefer to call it "UTF-8 signature".

The Unicode consortium thinks that the BOM can be used in UTF-8:

http://www.unicode.org/faq/utf_bom.html#29

The UTF-8 signature is very useful, and I would prefer if it would
be used instead of format-specific encoding declarations.

Regards,
Martin
