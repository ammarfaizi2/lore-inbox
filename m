Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130452AbRCPKIT>; Fri, 16 Mar 2001 05:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130446AbRCPKIJ>; Fri, 16 Mar 2001 05:08:09 -0500
Received: from t2.redhat.com ([199.183.24.243]:30460 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129854AbRCPKIB>; Fri, 16 Mar 2001 05:08:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU> 
In-Reply-To: <200103160224.SAA03920@csl.Stanford.EDU> 
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 9 potential copy_*_user bugs in 2.4.1 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 16 Mar 2001 10:06:48 +0000
Message-ID: <1886.984737208@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


engler@csl.Stanford.EDU said:
>  I wrote an extension to gcc that does global analysis to determine
> which pointers in 2.4.1 are ever treated as user space pointers (i.e,
> passed to copy_*_user, verify_area, etc) and then makes sure they are
> always treated that way.

Nice work - thanks. One request though, to you and anyone else doing such
cleanups - please could you list the affected files separately near the
beginning of your mail, so that people can tell at a glance whether there's
anything in there that might be their fault.

--
dwmw2


