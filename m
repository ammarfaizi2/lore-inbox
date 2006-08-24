Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWHXMac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWHXMac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWHXMac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:30:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:41507 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751197AbWHXMab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:30:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QyCclpOOzKrpVWeJJZYscAnffwJHB6LOg6Y3s151w4Rlnd3HXBRTGaBCAvGEPuLam/GivSsF5lyyUrfzqPgCOmhmK7qWKlxGRw07OlFgv6nQVC9u5/QrcUq9FSTtDAE7njBFiBbFpgIhE5HcWADGH4nPoiRdNMGP4lJmRhlG5ag=
Message-ID: <6bffcb0e0608240530g46c207a0x9dc595eb1dfff45b@mail.gmail.com>
Date: Thu, 24 Aug 2006 14:30:30 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-24-00-22.tar.gz uploaded
Cc: "Nathan Scott" <nathans@sgi.com>, xfs-masters@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200608240723.k7O7NsBB025642@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608240723.k7O7NsBB025642@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> The mm snapshot broken-out-2006-08-24-00-22.tar.gz has been uploaded to
>
>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-24-00-22.tar.gz
>
> It contains the following patches against 2.6.18-rc4:

Filesystem "loop4": Disabling barriers, not supported by the underlying device
XFS mounting filesystem loop4
Slab corruption: start=ef135b6c, len=304
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<fdd1c363>](xfs_buf_free+0xb8/0xbd [xfs])
0d0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6c 6b 6b 6b
Prev obj: start=ef135a30, len=304
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [<fdd19dad>](kmem_zone_alloc+0x51/0x97 [xfs])
000: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
010: ad 4e ad de ff ff ff ff ff ff ff ff 00 00 00 00
Next obj: start=ef135ca8, len=304
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<fdd1c363>](xfs_buf_free+0xb8/0xbd [xfs])
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm3/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
