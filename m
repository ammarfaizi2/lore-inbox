Return-Path: <linux-kernel-owner+w=401wt.eu-S1758505AbWLIV6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758505AbWLIV6F (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758519AbWLIV6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:58:04 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:60572 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758505AbWLIV6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:58:02 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457B315B.5030004@s5r6.in-berlin.de>
Date: Sat, 09 Dec 2006 22:57:47 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to
 kcalloc().
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>  <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>  <Pine.LNX.4.64.0612090855590.14206@localhost.localdomain> <84144f020612090613s28aeb485ua7c652393cff3f90@mail.gmail.com> <Pine.LNX.4.64.0612090913210.14456@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612090913210.14456@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
> On Sat, 9 Dec 2006, Pekka Enberg wrote:
>> On 12/9/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
>>> once the order of the kcalloc() args is corrected, that
>>> would be followed by a single subsequent patch that did the
>>> kcalloc->kzalloc transformation all at once.
>> ...and what would that buy us? Nothing. It *really* wants to use
>> kzalloc and the transformation is equivalent, so please make it one
>> patch.
> 
> no.  those two submissions represent two logically different "fixes"
> and i have no intention of combining them.

They are both *alloc() related cleanups without change in functionality.
-- 
Stefan Richter
-=====-=-==- ==-- -=--=
http://arcgraph.de/sr/
