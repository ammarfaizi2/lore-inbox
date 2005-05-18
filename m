Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVERHHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVERHHD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 03:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVERHHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 03:07:02 -0400
Received: from mta-fs-be-04.sunrise.ch ([194.158.229.33]:22696 "EHLO
	mail-fs.sunrise.ch") by vger.kernel.org with ESMTP id S262111AbVERHGz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 03:06:55 -0400
Message-ID: <428AE89C.2020503@email.it>
Date: Wed, 18 May 2005 09:02:52 +0200
From: Fabio Rosciano <malmostoso@email.it>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jdz@aigc.net
CC: linux-kernel@vger.kernel.org, vs@nl.linux.org, dsd@gentoo.org,
       gfraser@online.no, linux-fsdevel@vger.kernel.org,
       reiserfs-list@namesys.com, vs@namesys.com
Subject: Re: [2.6.12-rc4] Oops in reiserfs_panic [please CC]
References: <4255.24.115.31.119.1116366396.squirrel@mail.aigc.net>
In-Reply-To: <4255.24.115.31.119.1116366396.squirrel@mail.aigc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse D Zbikowski wrote:
> This looks to be the same bug reported by two Gentoo users against
> 2.6.12-rc4, as a regression from -rc3.  One reported data corruption.
> You should be able to work around by compiling with
> 
> CONFIG_REISERFS_CHECK=n
> 
> http://bugs.gentoo.org/show_bug.cgi?id=91968

Yep, it worked. Nasty bug though.

Thanks, for any other info just ask!

-- 
Best Regards, Jack
Debian Sid PPC
