Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVAUH1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVAUH1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVAUH1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:27:52 -0500
Received: from gizmo07bw.bigpond.com ([144.140.70.42]:48030 "HELO
	gizmo07bw.bigpond.com") by vger.kernel.org with SMTP
	id S262297AbVAUH1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:27:50 -0500
Message-ID: <41F0AEEF.8060707@bigpond.net.au>
Date: Fri, 21 Jan 2005 18:27:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: karim@opersys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
References: <41EF4E74.2000304@opersys.com> <20050120145046.GF13036@kroah.com> <41F05D11.5020109@opersys.com> <41F065C0.7070603@bigpond.net.au> <20050121063956.GB19288@kroah.com>
In-Reply-To: <20050121063956.GB19288@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Jan 21, 2005 at 01:15:28PM +1100, Peter Williams wrote:
> 
>>Perhaps the logical solution is to implement debugfs in terms of relayfs?
> 
> 
> What do you mean by this statement?

I mean that if, as you say, debugfs is very similar to relayfs only more 
restricted (i.e. a debugging option) then it should be implementable as 
an instance or specialization of the more general relayfs and that this 
should be a better solution than two independent implementations of 
similar functionality.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
