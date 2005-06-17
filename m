Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVFQSR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVFQSR1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVFQSR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:17:26 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:14298 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S262028AbVFQSRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:17:17 -0400
Message-ID: <42B313A6.7030004@zabbo.net>
Date: Fri, 17 Jun 2005 11:17:10 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Robert Love <rml@novell.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] inotify, improved.
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy> <42B227B5.3090509@yahoo.com.au> <1118972109.7280.13.camel@phantasy> <1119021336.3949.104.camel@betsy> <42B30654.4030307@zabbo.net> <20050617175455.GA1981@tentacle.dhs.org> <42B30EC1.60608@zabbo.net> <20050617181501.GB2220@tentacle.dhs.org>
In-Reply-To: <20050617181501.GB2220@tentacle.dhs.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My bad. Shouldn't we return the error code to user space though? We
> shouldn't be hiding errors in the app. How does read() handle an error
> part way through a read?

My preference is to give userspace a chance to work with what it can,
though I'm not sure what the N read paths do right now.

- z
