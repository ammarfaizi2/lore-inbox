Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVG2PMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVG2PMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVG2PMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:12:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:15276 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262613AbVG2PLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:11:09 -0400
Date: Fri, 29 Jul 2005 17:11:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: ?X?? <brianhsu.hsu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to get dentry from inode number?
Message-ID: <20050729151109.GA10453@wohnheim.fh-wedel.de>
References: <615cd8d10507290802690dd50f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <615cd8d10507290802690dd50f@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 July 2005 23:02:53 +0800, ?X?? wrote:
> 
> How can I get a full pathname from an inode number ?

That's fundamentally impossible to do.  Any given inode may have
multiple paths associated to it.  Think of hard links.

Jörn

-- 
"[One] doesn't need to know [...] how to cause a headache in order
to take an aspirin."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
