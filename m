Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265901AbUBKQh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUBKQh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:37:28 -0500
Received: from dictum-ext.geekmail.cc ([204.239.179.245]:35804 "EHLO
	mailer01.geekmail.cc") by vger.kernel.org with ESMTP
	id S265901AbUBKQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:37:26 -0500
Message-ID: <402A5A33.8050206@swapped.cc>
Date: Wed, 11 Feb 2004 08:37:07 -0800
From: Alex Pankratov <ap@swapped.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [1/2] hlist: replace explicit checks of hlist fields
 w/ func calls
References: <4029CB7B.3090409@swapped.cc>	<20040213231407.208204c4.ak@suse.de>	<4029D267.40307@swapped.cc> <20040214012805.52e4af60.ak@suse.de>
In-Reply-To: <20040214012805.52e4af60.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen wrote:

> On Tue, 10 Feb 2004 22:57:43 -0800
> Alex Pankratov <ap@swapped.cc> wrote:
> 
> Still your first patch was rather intrusive regarding interface changes,
> so it may be a good idea to wait for 2.7 with this.
> 

Fully agreed. I did a grep on an entire tree, which produced a
list of sources dependent on hlist. Then I temporarily renamed
next, first and pprev fields and configured and built an image.
This brought up all references to hlists within dependent code,
I fixed what's needed and that produced patch #1. There's still
a chance something's left unnoticed.

