Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751624AbWCUMxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbWCUMxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWCUMxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:53:36 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:26984 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751623AbWCUMxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:53:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5DS/YbZcMkw3leEXK8xMxWJDPvVEOHKIzhL6fSnmds6vuw7NtqTuFViCPKkrL02qPm7Z6CxZCS1q8PPG0beFig6nsE1gTkkVjKpju3Ar1z5KegAYrTa76iI6mQ7uaVptJhCQBY1bGBvs89hHVRdWBv9qfu6edPiLllZkf590v+M=  ;
Message-ID: <441FEFC7.5030109@yahoo.com.au>
Date: Tue, 21 Mar 2006 23:21:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo:
 Wired"
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
In-Reply-To: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> Export mlock(wired) info through file /proc/meminfo.
> 

If wired is solely for mlock pages... why not just call it
mlock/mlocked?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
