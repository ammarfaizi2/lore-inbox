Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSKVGoA>; Fri, 22 Nov 2002 01:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSKVGoA>; Fri, 22 Nov 2002 01:44:00 -0500
Received: from air-2.osdl.org ([65.172.181.6]:30694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265843AbSKVGn7>;
	Fri, 22 Nov 2002 01:43:59 -0500
Date: Thu, 21 Nov 2002 22:49:23 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Roland Dreier <roland@digitalvampire.org>
cc: dan carpenter <error27@email.com>, <linux-kernel@vger.kernel.org>,
       <smatch-kbugs@lists.sourceforge.net>,
       <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [LIST] large local declarations
In-Reply-To: <87vg2q15q5.fsf@love-shack.home.digitalvampire.org>
Message-ID: <Pine.LNX.4.33L2.0211212248250.4812-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2002, Roland Dreier wrote:

| >>>>> "dan" == dan carpenter <error27@email.com> writes:
|
|     dan> I have a smatch script (smatch.sf.net) that finds the the
|     dan> size of local variables.  I created an allyesconfig with
|     dan> 2.5.48 and tested it.  These were the functions that declared
|     dan> local datas with size of 5 digits or more (in bits).
|
| This is a minor complaint, but... why do you report the data sizes in
| bits?  I find myself forced to mentally divide every size by 8.  Every
| variable (obviously) has a size that's a whole number of bytes.  Why
| not just report bytes?

I second that.
It's not just Roland...

But thanks for doing it anyway.

-- 
~Randy

