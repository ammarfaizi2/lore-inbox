Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755296AbWK0AD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbWK0AD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbWK0AD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:03:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:39845 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755314AbWK0AD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:03:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Nh/xQcFRVju0ya/3Jr1UNtJsMBySbk/bgi8Lux4q7lbQyy7M3HNBjpCLxOJvozwkLvDic6o+a1Zhzr7ikT7uk2+Jos3Y+OYN0qZ8/duzzbgWr2q+gn0qBbs5TK4mkP/TN71D1zC0OCuK6nUF6c6Uo6Mb8LVGsTZnfEXKaTp8Y/A=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: futex hang with rpm in 2.6.17.1-2174_FC5
Date: Mon, 27 Nov 2006 01:02:50 +0100
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
References: <453917C2.8010201@candelatech.com> <20061021180005.GF30758@redhat.com> <453A622C.2020401@candelatech.com>
In-Reply-To: <453A622C.2020401@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611270102.50218.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 20:08, Ben Greear wrote:
> >  > or shouldn't rpm notice the previous process is dead and
> >  > clean it up itself?
> >  
> > Sounds sensible to me and you, but in the past sensible ideas and
> > rpm maintainers haven't gone hand in hand.
> >   
> Ahhh :)

Well said. rpm's source tarball size doubles with each release
and it contains such unexpected things as ELF manipulation
library. I have no idea what business rpm can possibly have with
parsing ELF headers.
--
vda
