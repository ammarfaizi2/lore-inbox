Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWG3Nb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWG3Nb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWG3Nb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:31:57 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:30862 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1750854AbWG3Nb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:31:56 -0400
Subject: Re: 2.6.18-rc3 - ReiserFS - warning: vs-8115: get_num_ver: not
	directory or indirect item
From: Redeeman <redeeman@metanurb.dk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hans Reiser <reiser@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com>
References: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 30 Jul 2006 15:31:46 +0200
Message-Id: <1154266306.13635.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-30 at 15:08 +0200, Jesper Juhl wrote:
> I just got a warning message with 2.6.18-rc3 that I've never seen before :
> 
>   ReiserFS: sda4: warning: vs-8115: get_num_ver: not directory or indirect item
> 
> The message showed up twice in dmesg during two parallel "make -j3"
> builds of the 2.6.18-rc3 kernel source in two sepperate directories.
> I've tried to reproduce it but without luck.
> 
> It would be nice if someone could tell me what the message means and
> wether or not I should be worried about it.
by default i would suggest worried mode.

what does fsck.reiserfs say?
> 

