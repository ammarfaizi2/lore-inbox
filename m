Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264214AbTH1UK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTH1UK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:10:59 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:23562 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S264214AbTH1UK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:10:58 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and hardware reports a non fatal incident
Date: Thu, 28 Aug 2003 20:02:00 +0100
User-Agent: KMail/1.5.3
References: <200308281548.44803.tomasz_czaus@go2.pl> <20030828084640.68fe827d.rddunlap@osdl.org>
In-Reply-To: <20030828084640.68fe827d.rddunlap@osdl.org>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308282002.00758.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 Aug 2003 16:46, Randy.Dunlap wrote:
> Use "parsemce" from here:
>   http://www.codemonkey.org.uk/projects/parsemce/
> to decode it.

Hi Randy,

The format seems to have changed rather a lot since that was written.  All I 
get is:

Aug 17 11:25:13 codewave kernel: MCE: The hardware reports a non fatal, 
correctable incident occurred on CPU 0.
Aug 17 11:25:13 codewave kernel: Bank 0: dc0000000000050b

...but what parsemce seems to be expecting is:

 Sample kernel output..
 Sep  4 21:43:41 hamlet kernel: CPU 0: Machine Check Exception: 
0000000000000004
Sep  4 21:43:41 hamlet kernel: Bank 1: f600200000000152 at 7600200000000152
Sep  4 21:43:41 hamlet kernel: Bank 2: d40040000000017a at 540040000000017a
Sep  4 21:43:41 hamlet kernel: Kernel panic: CPU context corrupt

As a result, I'm still no more enlightened.  I can't quite figure out from 
reading the parser what values to put where, as it seems to expect a few 
more than I have.  Any tips?

Ta,

Matt

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
