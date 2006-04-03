Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWDCQpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWDCQpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWDCQpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:45:52 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:27250 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751544AbWDCQpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:45:51 -0400
Message-ID: <443151B4.7010401@tmr.com>
Date: Mon, 03 Apr 2006 12:47:48 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060330 SeaMonkey/1.5a
MIME-Version: 1.0
To: Kir Kolyshkin <kir@openvz.org>
CC: akpm@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org>
In-Reply-To: <4429A17D.2050506@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kir Kolyshkin wrote:

> OpenVZ will have live zero downtime migration and suspend/resume some 
> time next month.
> 
Please clarify. Currently a migration involves:
- stopping or suspending the instance
- backing up the instance and all of its data
- creating an environment for the instance on a new machine
- transporting the data to a new machine
- installing the instance and all data
- starting the instance

If you could just briefly cover how you do each of these steps with zero
downtime...
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

