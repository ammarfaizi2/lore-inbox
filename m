Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUAEXIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAEXHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:07:40 -0500
Received: from pop.gmx.de ([213.165.64.20]:36267 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266013AbUAEXG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:06:56 -0500
X-Authenticated: #125400
Message-ID: <3FF9EDEF.9010900@gmx.de>
Date: Tue, 06 Jan 2004 00:06:23 +0100
From: Andreas Fester <Andreas.Fester@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.24 released
References: <1aDrl-81S-11@gated-at.bofh.it> <1aGfZ-3zX-33@gated-at.bofh.it> <1aGIx-4iy-25@gated-at.bofh.it> <1aHbG-4Xs-11@gated-at.bofh.it> <1aIri-6Nn-27@gated-at.bofh.it> <1aKj3-Y1-13@gated-at.bofh.it>
In-Reply-To: <1aKj3-Y1-13@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had the same problem with depmod reporting many
unresolved symbols. Seems that updating modutils
solves the problem. I was using modutils 2.4.12 on a
SuSE 8.2 system, after upgrading to the current modutils
2.4.26 depmod works properly.

Best Regards,

	Andreas

BTW: Documentation/Changes still lists modutils 2.4.2 as
Minimal Requirement, which does not seem to be true anymore;
I dont know which actually is the minimal requirement,
otherwise I would have sent a patch ;-) Maybe someone can
clarify this...

Markus Hästbacka wrote:
> On Mon, 2004-01-05 at 21:06, Adrian Bunk wrote:
> 
>>Please you doublecheck whether the following really fails for you:
>>
>>  cd linux-2.4.24
>>  mv .config /tmp
[...]

