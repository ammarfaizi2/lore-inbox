Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUBRVsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUBRVsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:48:42 -0500
Received: from herkules.viasys.com ([194.100.28.129]:16039 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S268213AbUBRVsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:48:41 -0500
Date: Wed, 18 Feb 2004 23:48:28 +0200
From: Ville Herva <vherva@viasys.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Robert White <rwhite@casabyte.com>, tridge@samba.org,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Al Viro'" <viro@parcelfarce.linux.theplanet.co.uk>,
       "'Neil Brown'" <neilb@cse.unsw.edu.au>
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040218214828.GC3767@viasys.com>
Reply-To: vherva@viasys.com
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAABSIByOpdrUqd8yc+ZmEhqQEAAAAA@casabyte.com> <Pine.LNX.4.58.0402171619010.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171619010.2154@home.osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 04:20:26PM -0800, you [Linus Torvalds] wrote:
> 
> This is but one reason why I will _refuse_ to make case insensitivity
> magically start happening on regular "open()" etc calls.
> 
> You'd literally have to use a _different_ system call to do a 
> case-insensitive file open. 

Tongue-in-cheek:

  int Open(const char *pathname, int flags); ?




-- v --

v@iki.fi
