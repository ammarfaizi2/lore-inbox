Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752270AbWCNFZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbWCNFZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 00:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbWCNFZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 00:25:23 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:1979 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751841AbWCNFZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 00:25:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ki6qlP572jkGE1uFNis8fP7X596HY8lSGH5MmGVNTamhBKcrvD6VBKbQlgzgxpqrdhU5L6BOyvj/WXpbvWbjp9c9jsOqXmO1hQCtlFCet+uhRoJQO95fbqT4eiddfVcbj0KJb3WGB5AKbEM1xSAhzX4spJe6+wmWBvJNVdKBJDQ=  ;
Message-ID: <44165398.2090900@yahoo.com.au>
Date: Tue, 14 Mar 2006 16:24:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: RFC: radix tree safety
References: <20060313155058.1389ee9a.akpm@osdl.org>	<20060314000114.24716.qmail@lwn.net> <20060313161435.30c2d865.akpm@osdl.org>
In-Reply-To: <20060313161435.30c2d865.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> corbet@lwn.net (Jonathan Corbet) wrote:

>>If we don't want the tests, fine, but it might make sense to fix the
>>interface documentation, at least, to note that "tag" is not an
>>arbitrary integer value.
>>
> 
> 
> Sure, we can live with the runtime cost of a documentation fix ;)

How about making the code self-documenting and more useful at the same
time: put RADIX_TREE_TAGS in radix-tree.h, and call it RADIX_TREE_MAX_TAGS

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
