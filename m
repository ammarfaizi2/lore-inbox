Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbVJNLBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbVJNLBJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 07:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVJNLBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 07:01:09 -0400
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:26157 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750717AbVJNLBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 07:01:07 -0400
Message-ID: <20051014120104.hiwjp184mc8cogw8@unsolicited.net>
Date: Fri, 14 Oct 2005 12:01:04 +0100
From: David R <david@unsolicited.net>
To: Manfred Scherer <Manfred.Scherer.Mhm@t-online.de>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH for reiserfs, max 2GB in version 3.5
References: <434E5541.5030307@t-online.de>
In-Reply-To: <434E5541.5030307@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-2;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4-RC1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manfred Scherer <Manfred.Scherer.Mhm@t-online.de>:

> If we create a file greater than 2GB in a reiserfs v3.5,
> the file size will not be checked and the file can be
> created like this:
>

I'm confused. I've got lots of video files > 2GB using Reiser 3

m@server:/mnt/raid/> dd if=051008-19.04.05.mpg of=/dev/null bs=1024
2573276+1 records in
2573276+1 records out
m@server:/mnt/raid/> ls -l 051008-19.04.05.mpg
-rw-r--r--  1 m users 2635034636 2005-10-08 21:15 051008-19.04.05.mpg

that seem to work just fine?

David.

