Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268915AbUHMA5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268915AbUHMA5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 20:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268917AbUHMA5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 20:57:35 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:30392 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268915AbUHMA5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 20:57:33 -0400
Message-ID: <411C11FB.305@yahoo.com.au>
Date: Fri, 13 Aug 2004 10:57:31 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Omar Kilani <omar.kilani@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance Degradation: 2.6.8-rc4-bk1 vs RHEL 2.4.21-15.0.3
References: <f0cc3e3e040812054511f253aa@mail.gmail.com> <295911442.20040812150922@dns.toxicfilms.tv> <f0cc3e3e04081206354300a561@mail.gmail.com> <f0cc3e3e04081206568f413e5@mail.gmail.com>
In-Reply-To: <f0cc3e3e04081206568f413e5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Omar Kilani wrote:

>Anything else I should be monitoring?
>
>

Take a profile of each kernel. Boot with profile=1, then run:

    echo 0 > /proc/profile ; ab --foo --bar ; readprofile | sort -nr | 
head -n30 > profile.out

And send in the profiles for both kernels.


