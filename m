Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293121AbSBZBcN>; Mon, 25 Feb 2002 20:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293219AbSBZBby>; Mon, 25 Feb 2002 20:31:54 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:7106 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293121AbSBZBbu>;
	Mon, 25 Feb 2002 20:31:50 -0500
Date: Mon, 25 Feb 2002 17:32:06 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Shawn Starr <spstarr@sh0n.net>, Linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the	tree
Message-ID: <4360000.1014687125@flay>
In-Reply-To: <1014686150.18834.2.camel@coredump>
In-Reply-To: <200202260135.18913.Dieter.Nuetzel@hamburg.de> <1014686150.18834.2.camel@coredump>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not to begin the flamewar, but no thanks. rmap-12f blows -aa away AFAIK
> on this P200 w/ 64MB ram.

rmap still sucks on large systems though. I'd love to see rmap
in the main kernel, but it needs to get the scalability fixed first.
The main problem seems to be pagemap_lru_lock ... Rik & crew 
know about this problem, but let's give them some time to fix it 
before rmap gets put into mainline ....

Martin.



