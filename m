Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265636AbVBETyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbVBETyf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbVBETye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 14:54:34 -0500
Received: from terminus.zytor.com ([209.128.68.124]:62622 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265636AbVBETyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 14:54:18 -0500
Message-ID: <420523E0.9090603@zytor.com>
Date: Sat, 05 Feb 2005 11:52:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add compiler-gcc4.h
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de> <41FCFED4.1070301@tiscali.de> <ctrtbe$570$1@terminus.zytor.com> <20050205135026.GC3129@stusta.de> <42051460.9060208@zytor.com> <20050205193813.GG3129@stusta.de>
In-Reply-To: <20050205193813.GG3129@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> It doesn't seem to be logical for everyone whether compiler-gcc+.h or 
> compiler-gcc3.h is used for gcc 4.0 ...
> 
> Perhaps compiler-gcc+.h (which wasn't always updated when 
> compiler-gcc3.h was updated) should be removed?
> 

That would make more sense.  After all, gcc5+ can use the gcc4 file 
until a gcc5 file proper is created.

	-hpa
