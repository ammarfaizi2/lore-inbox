Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293010AbSCTTnQ>; Wed, 20 Mar 2002 14:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311285AbSCTTnG>; Wed, 20 Mar 2002 14:43:06 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:52515 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S293010AbSCTTmz>; Wed, 20 Mar 2002 14:42:55 -0500
Message-ID: <61DB42B180EAB34E9D28346C11535A78062DA2@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        "'Chris Meadors'" <clubneon@hereintown.net>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: task_struct changes?
Date: Wed, 20 Mar 2002 14:42:18 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not sure about the p_opptr, but I bet you'll find the same 
> type of change.  
>
> I found this on Sparc64 as well, if you grep the 2.5.7 patch 
> file, you should be able to find p_opptr pretty quickly, I bet.
> 
As a matter of fact, I did it for you, and it looks like you'll need this
for p_opptr:

p_opptr became real_parent

task_struct->p_opptr would become task_struct->real_parent 

Hope this helps you out..

Bruce h.
