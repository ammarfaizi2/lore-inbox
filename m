Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263414AbTCNQqt>; Fri, 14 Mar 2003 11:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263417AbTCNQqt>; Fri, 14 Mar 2003 11:46:49 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6089 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263414AbTCNQqs>;
	Fri, 14 Mar 2003 11:46:48 -0500
Date: Fri, 14 Mar 2003 08:54:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: braam@clusterfs.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix stack usage in fs/intermezzo/journal.c
Message-Id: <20030314085453.0eb57b9b.rddunlap@osdl.org>
In-Reply-To: <20030314165521.GE23161@wohnheim.fh-wedel.de>
References: <20030314155352.GD27154@wohnheim.fh-wedel.de>
	<20030314080930.5ff3cc80.rddunlap@osdl.org>
	<20030314164445.GC23161@wohnheim.fh-wedel.de>
	<20030314084536.522ad81c.rddunlap@osdl.org>
	<20030314165521.GE23161@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003 17:55:21 +0100 Joern Engel <joern@wohnheim.fh-wedel.de> wrote:

| On Fri, 14 March 2003 08:45:36 -0800, Randy.Dunlap wrote:
| > 
| > If you are concerned about namespace & collisions, you can
| > #undef BUF_SIZE
| > after each function.
| 
| Not, if BUF_SIZE was #defined before and should maintain that value.
| I could go and check for this specific case, but this is better left
| to the maintainer, imho.

Yes, that's right.

Actually I meant for however someone chose to spell BUF_SIZE,
but that's enough said.

Bye.

--
~Randy
