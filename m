Return-Path: <linux-kernel-owner+w=401wt.eu-S1751251AbXAUHLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbXAUHLp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 02:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbXAUHLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 02:11:45 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38595 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbXAUHLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 02:11:45 -0500
Message-ID: <45B3122C.20301@zytor.com>
Date: Sat, 20 Jan 2007 23:11:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: davids@webmaster.com
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
References: <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 
> 	Talk about a cure worse than the disease! So you're saying that 256MB flash
> cards could be advertised as having 268.4MB? A 512MB RAM stick is
> mislabelled and could correctly say 536.8MB? That's just plain craziness.
> 
> 	Adopting IEC 60027-2 just replaces a set of well-understood problems with
> all new problems.
> 

Except that you're wrong above.  Most 512 MB flash cards are less than 
512 MiB; most of them are, in fact, around 512 MB!  RAM, of course, is 
consistently 512 MiB.

This little tidbit discovered in the process of working on an 
application which required powers-of-two flash cards, and finding that 
one does have to use one size larger...

	-hpa
