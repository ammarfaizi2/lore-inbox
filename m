Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUHBGag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUHBGag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 02:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUHBGag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 02:30:36 -0400
Received: from zmamail03.zma.compaq.com ([161.114.64.103]:32263 "EHLO
	zmamail03.zma.compaq.com") by vger.kernel.org with ESMTP
	id S266296AbUHBGae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 02:30:34 -0400
Message-ID: <410DDFA2.40107@hp.com>
Date: Mon, 02 Aug 2004 12:00:58 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-cluster@redhat.com,
       ssic-linux-devel <ssic-linux-devel@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] OpenSSI 1.0.0 released!!
References: <2o0e0-6qx-5@gated-at.bofh.it> <m37jsk42hw.fsf@averell.firstfloor.org>
In-Reply-To: <m37jsk42hw.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@hp.com> writes:
> 
> 
>>Hi,
>>
>>Sorry for the cross post. I came across this on OpenSSI website. I
>>guess others may also be interested.
> 
> 
> 
> [....] Congratulations. But I was a bit disappointed that there
> wasn't a tarball with the kernel patches and other sources.
> Any chance to add that to the site? 
> 
>

I have posted  the diff at
http://www.openssi.org/contrib/linux-ssi.diff.gz

This is against kernel linux-rh-2.4.20-31.9 which can be found in the 
OpenSSI CVS as srpms/linux-rh-2.4.20-31.9.tar.bz2

$cvs -d:pserver:anonymous@cvs.openssi.org:/cvsroot/ssic-linux login
$cvs -z3 -d:pserver:anonymous@cvs.openssi.org:/cvsroot/sic-linux co -r 
OPENSSI-RH  srpms/linux-rh-2.4.20-31.9.tar.bz2


This patch include the IPVS, KDB and OpenSSI changes

For 2.6 we are planning to group the changes into small patches that is 
  easy to review.


All the other sources can be found as tar.gz at ( 
http://www.openssi.org/contrib/debian/openssidebs/sources/ )or better by 
doing apt-get source package on a debian system :)

-aneesh
