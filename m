Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTDIHsM (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbTDIHsM (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:48:12 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:4356 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262886AbTDIHsL (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:48:11 -0400
Message-ID: <3E93D345.5090209@aitel.hist.no>
Date: Wed, 09 Apr 2003 10:01:09 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-(bk) == horrible response times for non X11 applications
References: <Pine.LNX.4.50.0304061757240.2268-100000@montezuma.mastecende.com> <20030406182435.5a243297.akpm@digeo.com> <20030409064215.GC10141@unthought.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard wrote:
> On Sun, Apr 06, 2003 at 06:24:35PM -0700, Andrew Morton wrote:
[...]
>>the problem with setiathome is that it displays something every now and
>>then - so it gets a backboost from X, and hovers at a relatively high
>>priority.
> 
> 
> Why are niced processes boosted?   Does that make sense?
> 
> If only non-niced processes were boosted, wouldn't that pretty much fix
> the problem?
> 
You'd have exactly the same problem for any non-niced cpu hog
that displays something now and then. A non-niced cpu hog is supposed
to be ok because the interactive processes are boosted above them.

Gui is becoming popular, so many compute tasks get some sort of
display, even if it only is a progress bar.

Helge Hafting


