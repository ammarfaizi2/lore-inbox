Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132422AbRDUBji>; Fri, 20 Apr 2001 21:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbRDUBj2>; Fri, 20 Apr 2001 21:39:28 -0400
Received: from [216.151.155.121] ([216.151.155.121]:25615 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S132422AbRDUBjS>; Fri, 20 Apr 2001 21:39:18 -0400
To: lee@ricis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Current status of NTFS support
In-Reply-To: <86256A34.0079A841.00@smtpnotes.altec.com>
	<01042101555600.03154@blackbox> <01042020185806.00845@linux>
From: Doug McNaught <doug@wireboard.com>
Date: 20 Apr 2001 21:39:13 -0400
In-Reply-To: Lee Leahu's message of "Fri, 20 Apr 2001 20:18:58 -0500"
Message-ID: <m34rvjuj3y.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Leahu <lee@ricis.com> writes:

> would somebody be kind enough to explain why writing to 
> the ntfs file system is extremely dangerous,  and what are the
> developers doing to make writing to ntfs filesystem safe?

It's dangerous because NTFS is a proprietary format, and the full
rules for updating it (including journals etc) are known only to
Microsoft and those that have signed Microsoft NDAs.  If you update it
incorrectly it gets corrupted and you will lose data.  It's certainly
possible to reverse-engineer these rules, but very difficult and
time-consuming.

-Doug
-- 
The rain man gave me two cures; he said jump right in,
The first was Texas medicine--the second was just railroad gin,
And like a fool I mixed them, and it strangled up my mind,
Now people just get uglier, and I got no sense of time...          --Dylan
