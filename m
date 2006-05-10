Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWEJWbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWEJWbq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWEJWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:31:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1248
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751518AbWEJWbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:31:45 -0400
Date: Wed, 10 May 2006 15:31:29 -0700 (PDT)
Message-Id: <20060510.153129.122741274.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: akpm@osdl.org, dwalker@mvista.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060510221024.GH27946@ftp.linux.org.uk>
References: <20060510162106.GC27946@ftp.linux.org.uk>
	<20060510150321.11262b24.akpm@osdl.org>
	<20060510221024.GH27946@ftp.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 10 May 2006 23:10:24 +0100

> But that's the argument in favour of using diff, not shutting the
> bogus warnings up...

IMHO, the tree should build with -Werror without exception.
Once you have that basis, new ones will not show up easily
and the hard part of the battle has been won.

Yes, people will post a lot of bogus versions of warning fixes, but
we're already good at flaming those off already :-)
