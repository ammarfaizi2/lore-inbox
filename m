Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWBSEXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWBSEXg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 23:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWBSEXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 23:23:36 -0500
Received: from relay4.usu.ru ([194.226.235.39]:46034 "EHLO relay4.usu.ru")
	by vger.kernel.org with ESMTP id S1750879AbWBSEXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 23:23:36 -0500
Message-ID: <43F7F2FA.2060102@ums.usu.ru>
Date: Sun, 19 Feb 2006 09:24:26 +0500
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "=?UTF-8?B?QWRhbSBUbGHFgmth?=" <atlka@pg.gda.pl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <20060218025921.7456e168.akpm@osdl.org> <43F744C6.8020209@pg.gda.pl>
In-Reply-To: <43F744C6.8020209@pg.gda.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.15; AVE: 6.33.1.0; VDF: 6.33.1.5; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Tlałka wrote:

> Maybe I should remember all bytes of the UTF-sequence to use their 
> values as a last resort char in case of malformed sequence and 0xfffd
> not defined?

Please don't do that. Display question marks instead in the case when 
0xfffd is not defined.

-- 
Alexander E. Patrakov
