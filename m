Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVGGBoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVGGBoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGGBmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:42:45 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:44596 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262451AbVGGBls convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:41:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IdD2aGdV6NfDUi6gDmGMInsQBNc4ZzBM2BlJ1UApXe9lhvAZc5WpAMYsCFix8duXESyugvmndwpPTgvC+0DEENaKugXZKVKMPOddOmAYs7ECHA+6CCM8HTZm4DXHLH2nl7nSHnkLKDzSaXaaH9vtH40nDISVRKWg1J/vasVBINk=
Message-ID: <d4dc44d505070618411455b238@mail.gmail.com>
Date: Thu, 7 Jul 2005 03:41:43 +0200
From: Schneelocke <schneelocke@gmail.com>
Reply-To: Schneelocke <schneelocke@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Cc: Miles Lane <miles.lane@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050706152724.7645dd61.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd05070301417531fac2@mail.gmail.com>
	 <20050706152724.7645dd61.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/05, Andrew Morton <akpm@osdl.org> wrote:
> One thing you could do is to disable `hald' (what is that anyway?) by
> renaming it and try to get the system to boot.  Then run `hald' by hand,
> under strace, work out which sysfs file it was trying to close.

Probably the Hardware Abstraction Layer [1] daemon.

1. http://freedesktop.org/wiki/Software_2fhal
-- 
schnee
