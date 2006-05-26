Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751295AbWEZTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbWEZTNW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWEZTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:13:22 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:47249 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751295AbWEZTNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:13:22 -0400
Date: Fri, 26 May 2006 21:12:42 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ulrich Drepper <drepper@redhat.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       serue@us.ibm.com, sam@vilain.net, clg@fr.ibm.com, dev@sw.ru
Subject: Re: [PATCH] POSIX-hostname up to 255 characters
In-Reply-To: <44774F0B.8010805@redhat.com>
Message-ID: <Pine.LNX.4.61.0605262111130.11445@yvahk01.tjqt.qr>
References: <20060525204534.4068e730.rdunlap@xenotime.net>
 <m1zmh5b129.fsf@ebiederm.dsl.xmission.com> <20060526144216.GZ13513@lug-owl.de>
 <Pine.LNX.4.58.0605261025230.9655@shark.he.net> <20060526180131.GA13513@lug-owl.de>
 <Pine.LNX.4.61.0605261409300.8002@chaos.analogic.com> <447748E4.4050908@redhat.com>
 <Pine.LNX.4.61.0605261430370.8339@chaos.analogic.com> <44774F0B.8010805@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It is written (on so-called compatible machines like my Sun) as:
>> 
>> #define MAXHOSTNAMELEN _POSIX_HOST_NAME_MAX
>> 
>> Then in limits.h, I see:
>> 
>> #define _POSIX_HOST_NAME_MAX 64
>
>That's wrong.  The value must be 255, at least for the current spec.
>You really should verify your statements before making them public.  The
>POSIX spec is available in HTML for for viewing for free from the
>OpenGroup.  What a specific implementation does is not authoritative.
>

Let's all be happy with it that some systens have the maximum hostname length
at 64 or 255... thay way, applications do not tend to depend on it.
(Cf. Linux and the 100->1000 Hz change which _did_ turn up something.)


Jan Engelhardt
-- 
