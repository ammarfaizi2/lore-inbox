Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUCKJtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUCKJtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:49:01 -0500
Received: from main.gmane.org ([80.91.224.249]:33412 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261160AbUCKJs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:48:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: (0 == foo), rather than (foo == 0)
Date: Thu, 11 Mar 2004 10:48:54 +0100
Message-ID: <yw1x7jxrzpbt.fsf@kth.se>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org>
 <Pine.LNX.4.53.0403101324120.18709@chaos> <404F9E28.4040706@aurema.com>
 <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
 <404FD81D.3010502@aurema.com>
 <Pine.LNX.4.58.0403101917060.1045@ppc970.osdl.org>
 <404FEDAC.8090300@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:5aV4ZWpvUmbVB1Y7OFH87XkCYUc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski <stesmi@stesmi.com> writes:

> Hi Linus.
>
>> The warning should be there whether there are parenthesis or not,
>> and it should state that you should have an explicit inequality
>> expression. So if you have
>> 	if (a = b) 		...
>> and you really _mean_ that, then the way to write it sanely is to
>> just write it as
>> 	if ((a = b) != 0)
>> 		...
>> which makes it much clearer what you're actually doing.
>
> Or actually change it to
>
> a = b;
> if (a)

That doesn't work with while().

-- 
Måns Rullgård
mru@kth.se

