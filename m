Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUCKK3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 05:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUCKK3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 05:29:05 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:48860 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261159AbUCKK3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 05:29:01 -0500
Message-ID: <40503F6D.8010009@stesmi.com>
Date: Thu, 11 Mar 2004 11:29:01 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: (0 == foo), rather than (foo == 0)
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos> <404F9E28.4040706@aurema.com> <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org> <404FD81D.3010502@aurema.com> <Pine.LNX.4.58.0403101917060.1045@ppc970.osdl.org> <404FEDAC.8090300@stesmi.com> <yw1x7jxrzpbt.fsf@kth.se>
In-Reply-To: <yw1x7jxrzpbt.fsf@kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Måns.

>>>The warning should be there whether there are parenthesis or not,
>>>and it should state that you should have an explicit inequality
>>>expression. So if you have
>>>	if (a = b) 		...
>>>and you really _mean_ that, then the way to write it sanely is to
>>>just write it as
>>>	if ((a = b) != 0)
>>>		...
>>>which makes it much clearer what you're actually doing.
>>
>>Or actually change it to
>>
>>a = b;
>>if (a)
> 
> That doesn't work with while().
> 

True. Didn't think of that but then the example used
was an if().

// Stefan
