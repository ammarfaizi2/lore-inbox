Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965270AbVIOVxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbVIOVxN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965272AbVIOVxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:53:13 -0400
Received: from gw.goop.org ([64.81.55.164]:47818 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965270AbVIOVxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:53:12 -0400
Message-ID: <4329ED4E.6000405@goop.org>
Date: Thu, 15 Sep 2005 14:53:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, hpa@zytor.com,
       bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com> <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com> <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com> <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com> <20050910014543.1be53260.akpm@osdl.org> <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com> <20050910150446.116dd261.akpm@osdl.org> <E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com> <20050910174818.579bc287.akpm@osdl.org> <93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>
In-Reply-To: <93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> This would make life a million times easier for the UML people,
> the glibc people, the klibc people, and the linux-libc-headers
> maintainer


Valgrind could definitely use this; it currently has its own private
kernel ABI definitions, which are a pain.

    J
