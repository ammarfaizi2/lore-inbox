Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbULaL0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbULaL0d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbULaL0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:26:33 -0500
Received: from quechua.inka.de ([193.197.184.2]:52453 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261853AbULaL0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:26:32 -0500
Date: Fri, 31 Dec 2004 12:26:25 +0100
From: Eduard Bloch <edi@gmx.de>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: Kill O(n^2) algorithm in swsusp
Message-ID: <20041231112625.GA28483@zombie.inka.de>
References: <20041225175453.GA10222@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225175453.GA10222@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Pavel Machek [Sat, Dec 25 2004, 06:54:54PM]:
> Hi!
> 
> Some machines are spending minutes of CPU time during suspend in
> stupid O(n^2) algorithm. This patch replaces it with O(n) algorithm,
> making swsusp usable to some people.
> 
> I'd like people to test this. It should probably spend few weeks 

Has been working quite stable for some days now (and countless reboots)
with kernel 2.6.9. And is as fast as swsusp2 (but works reliable ;-).

Regards,
Eduard.
-- 
In the beginning was the word, and the word was content-type: text/plain
