Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274737AbRIUBzN>; Thu, 20 Sep 2001 21:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274739AbRIUBzD>; Thu, 20 Sep 2001 21:55:03 -0400
Received: from zok.sgi.com ([204.94.215.101]:7811 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274737AbRIUByv>;
	Thu, 20 Sep 2001 21:54:51 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12 
In-Reply-To: Your message of "Thu, 20 Sep 2001 08:02:45 MST."
             <3BAA0515.9CC823A1@osdlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Sep 2001 11:54:03 +1000
Message-ID: <6721.1001037243@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 08:02:45 -0700, 
"Randy.Dunlap" <rddunlap@osdlab.org> wrote:
>Usage is:  ksysmap [system_map_file] offset
>and it spits out address/symbol before offset, exact match if

I like it!

Idea pinched for ksymoops 2.4.3; ksymoops -A "address list", any words
in the -A list are treated as addresses and looked up in the composite
system map, including modules.

