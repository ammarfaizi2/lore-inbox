Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWGSORx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWGSORx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 10:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWGSORw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 10:17:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:19983 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964848AbWGSORw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 10:17:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=VuI8RjUH2oRUFBmnuSO0gWKMaKx2/0KNsGwWvG600kTOmdsfzMSevnEs9dV0Z4jLbAAaAeLvuZLPMR8ewhHdDJMWGY27WvyyJn2tk4anjM8RqE73fcw8qbTNQKIF7S0IgYedj3ExhXEdE6RGNPaLi6hjsANJzz5voFjP4UuonCY=
Message-ID: <67dc30140607190717r57ed2fe5w719dcca896110d8@mail.gmail.com>
Date: Wed, 19 Jul 2006 16:17:50 +0200
From: "Mattias Hedenskog" <ml@magog.se>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS breakage in 2.6.18-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 809cfeefed20ab7c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That looks like the death knell of my /, which succumbed on Friday as
> a result (I believe) of the corruption bug that was in 2.6.16/17.
> Ironically enough, I also saw the problem during an aptitude upgrade.

Hi all,

I just want to confirm this bug as well and unfortunately it was my
system disk too who had to take the hit. Im running 2.6.16 and its
reproducible in 2.6.17 and 2.6.18-rc1 as well. When I tried to repair
the fs I got the same error as in the previous post, running xfsprogs
2.8.4. I haven't had the time to debug this issue further because the
box is quite critical but I'll keep an eye on the other disks on the
system still running xfs.

Regards,
Mattias Hedenskog
