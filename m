Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264481AbTCXWli>; Mon, 24 Mar 2003 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264482AbTCXWlh>; Mon, 24 Mar 2003 17:41:37 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:44300 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264481AbTCXWlg>; Mon, 24 Mar 2003 17:41:36 -0500
Date: Mon, 24 Mar 2003 23:52:39 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries.Brouwer@cwi.nl
cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] revert register_chrdev_region change
In-Reply-To: <UTC200303242240.h2OMe4Z24484.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.44.0303242346150.5042-100000@serv>
References: <UTC200303242240.h2OMe4Z24484.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Mar 2003 Andries.Brouwer@cwi.nl wrote:

>     So which problem requires a complex (sub)ranges solution?
> 
> Roman, please. There is no need to invent discussions.
> Al wrote certain code. It is not my code. I mentioned
> that this code has certain properties.
> 
> If you want to know why Al wrote the code he wrote, ask him.

Huh? What am I inventing?
You removed the character device hash. You removed the i_cdev member. You 
added the region support. Which part of the kernel will use this? You must 
have a reason for doing this, so I don't understand your reference to Al.

bye, Roman

