Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268700AbUJKFsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbUJKFsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 01:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUJKFsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 01:48:19 -0400
Received: from cathy.bmts.com ([216.183.128.202]:53176 "EHLO cathy.bmts.com")
	by vger.kernel.org with ESMTP id S268700AbUJKFsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 01:48:17 -0400
Date: Mon, 11 Oct 2004 01:47:47 -0400
From: Mike Houston <mikeserv@bmts.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm3 woes
Message-Id: <20041011014747.128d92c5.mikeserv@bmts.com>
In-Reply-To: <4169FCB5.8050808@tequila.co.jp>
References: <4169FCB5.8050808@tequila.co.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-bmts-MailScanner: Found to be clean
X-bmts-MailScanner-SpamCheck: 
X-MailScanner-From: mikeserv@bmts.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 12:23:33 +0900
Clemens Schwaighofer <cs@tequila.co.jp> wrote:

> 
> Hi,
> 
> System: debian/unstable
> 
> I just tried 2.6.9-rc3-mm3 and I have two problems:
> 
> - - he calls himself 2.6.9-rc-mm31, yeah 31. I don't know where this
> comes from, because in the Makefile itself it is mm3. Whatever makes
> him do that, I don't know, but he install himselfs like this,
> perhaps the problems come from that

Hello, I had something like that happen the other day because without
paying attention,  I said 'n' to the question of "Local version -
append to kernel release" during oldconfig instead of leaving it
blank. It was 2.6.9-rc3n

Check to make sure you haven't done something similar (it's under
General Setup).

-- 
