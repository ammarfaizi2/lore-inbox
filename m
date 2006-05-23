Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWEWJRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWEWJRe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 05:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWEWJRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 05:17:34 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:56423 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932140AbWEWJRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 05:17:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Bg5HE0fvdptEhbveUiW3i/Bl+K8X3HfvU9mSfBYfzailQh3jJ5NYm158+b4VATadqMGWsUiq19y1DEsHh4UHTcHOHnThL803Ti63n1Tq5Al+uec9mHHSfsvLnwRQThx5am1G5/clUP7ksj6HwNd0KRbrftILHLISSxEr1XwGUsc=  ;
Message-ID: <4472D327.3060808@yahoo.com.au>
Date: Tue, 23 May 2006 19:17:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
CC: Con Kolivas <kernel@kolivas.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. - random reboot problem
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs> <200605222117.27433.kernel@kolivas.org> <031001c67db1$a8c4a1e0$1800a8c0@dcccs> <200605230112.45564.kernel@kolivas.org> <047401c67de3$a05a52c0$1800a8c0@dcccs>
In-Reply-To: <047401c67de3$a05a52c0$1800a8c0@dcccs>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haar János wrote:

> OK, it is enough, to switch to 64bit, thanks!
> 
> But i have a little problem.
> My node #3 reboots again.
> 
> At this point i have run out of ideas. :-(
> 
> This is checked already:
> 
> - the complete hardware, except the 12 hdd. (smart reports, no errors at
> all, 4x ide + 8xSATA all 300GB.)
> - the SMP race. (checked with non-smp kernel)
> - APIC/ACPI (tested with non...  kernel)
> - the e1000 driver (tested with realtek gige adapter)
> - the complete filesystem, OS (NFS-ROOT, and copy between nodes.)
> - the memory allocation proble, (checked with debug-kernel, and rised
> min_free_kbytes)
> 
> The systems only service is nbd. (nbd-server serving md0, raid4 array)
> 
> Anybody have an idea?

Bad hardware. Run memtest overnight. Can your power supply deal with
that many drives? etc.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
