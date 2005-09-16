Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbVIPUe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbVIPUe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVIPUe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:34:26 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:44742 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750841AbVIPUeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:34:25 -0400
Message-ID: <432B2C49.8080008@v.loewis.de>
Date: Fri, 16 Sep 2005 22:34:17 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it> <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it>
In-Reply-To: <4NtL0-5lQ-13@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> I doubt that. For ages people were using several different encodings on
> a single system (at least here in .cz) without any markers and although
> there were some rough edges, almost everything worked. Now we do the same
> with ISO-8859-2 and UTF-8, again with no need for a marker.

This is true for text files, where a human reader can interpret the data
correctly even in absence of a declaration. For programming languages,
this is typically not the case. Instead, in order to correctly interpret
the source code, you need to declare the encoding. For a script, this
should be done inside the file itself, as there is no explicit
invocation of a compiler or some such where the script encoding could
be specified externally.

Regards,
Martin
