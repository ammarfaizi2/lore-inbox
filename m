Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVJHB1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVJHB1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVJHB1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:27:33 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:44381 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932105AbVJHB1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:27:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UDAcpa4YvMIqFxxm96Nn2gSOrdNk3hnyBmiIDn1lX8xmo1f/799vhKPSRp+MC36NDiRIMbGwWlzBYR+O9c6K6JIqOvy4EldJkxHbyai1cPq0uWL1ax59+GRxARSUHWGlJGViKIVNbcgwgaB61DVFUFaraUN6ESAOtBTD5ciI87Y=  ;
Message-ID: <434720B6.5060600@yahoo.com.au>
Date: Sat, 08 Oct 2005 11:28:22 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel compiling performance challenge
References: <43464F62.8010503@yahoo.com.au>
In-Reply-To: <43464F62.8010503@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Attached is a rollup against 2.6.14-rc3. I don't currently have any
> webspace handy, so I can't host a broken-out tarball anywhere yet.
> 

Hmm, a wayward hunk to net/core/skbuff.c slipped in there - it
is wrong. Just delete the net/core/skbuff.c part of the patch
before applying it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
