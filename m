Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263403AbTCNSLl>; Fri, 14 Mar 2003 13:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbTCNSLl>; Fri, 14 Mar 2003 13:11:41 -0500
Received: from moraine.clusterfs.com ([216.138.243.178]:43224 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id <S263403AbTCNSLk>; Fri, 14 Mar 2003 13:11:40 -0500
Date: Fri, 14 Mar 2003 11:21:13 -0700
From: Peter Braam <braam@clusterfs.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>, chyang@clusterfs.com
Cc: Joern Engel <joern@wohnheim.fh-wedel.de>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix stack usage in fs/intermezzo/journal.c
Message-ID: <20030314182113.GD11501@peter.cfs>
References: <20030314155352.GD27154@wohnheim.fh-wedel.de> <20030314080930.5ff3cc80.rddunlap@osdl.org> <20030314164445.GC23161@wohnheim.fh-wedel.de> <20030314084536.522ad81c.rddunlap@osdl.org> <20030314165521.GE23161@wohnheim.fh-wedel.de> <20030314085453.0eb57b9b.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314085453.0eb57b9b.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Go for it.  Chen Yang, put it in our tree too and fix it for 2.5 as
well. 

- peter -


On Fri, Mar 14, 2003 at 08:54:53AM -0800, Randy.Dunlap wrote:
> On Fri, 14 Mar 2003 17:55:21 +0100 Joern Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> | On Fri, 14 March 2003 08:45:36 -0800, Randy.Dunlap wrote:
> | > 
> | > If you are concerned about namespace & collisions, you can
> | > #undef BUF_SIZE
> | > after each function.
> | 
> | Not, if BUF_SIZE was #defined before and should maintain that value.
> | I could go and check for this specific case, but this is better left
> | to the maintainer, imho.
> 
> Yes, that's right.
> 
> Actually I meant for however someone chose to spell BUF_SIZE,
> but that's enough said.
> 
> Bye.
> 
> --
> ~Randy
- Peter -
