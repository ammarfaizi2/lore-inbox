Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTIDSBY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbTIDSBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:01:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:18125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265387AbTIDSA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:00:58 -0400
Message-ID: <32888.4.4.25.4.1062698455.squirrel@www.osdl.org>
Date: Thu, 4 Sep 2003 11:00:55 -0700 (PDT)
Subject: Re: [PATCH] ikconfig - cleanups
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <shemminger@osdl.org>
In-Reply-To: <20030904105154.7fb8a628.shemminger@osdl.org>
References: <20030904105154.7fb8a628.shemminger@osdl.org>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please reconcile it with
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/broken-out/ikconfig-gzipped.patch

and then it can go in


> Cleanup ikconfig
> 	- use single_open for built_with file.
> 	- get rid of unneeded globals
> 	- use copy_to_user instead of char at a time
> 	- only need the read routine, proc defaults to correct behaviour
> 	  for the rest.

~Randy



