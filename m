Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSFDDlv>; Mon, 3 Jun 2002 23:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316210AbSFDDlu>; Mon, 3 Jun 2002 23:41:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26888 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316204AbSFDDls>;
	Mon, 3 Jun 2002 23:41:48 -0400
Message-ID: <3CFC367C.1080300@mandrakesoft.com>
Date: Mon, 03 Jun 2002 23:39:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Austin Gonyou <austin@coremetrics.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Max groups at 32?
In-Reply-To: <1023161504.4595.5.camel@UberGeek>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Austin Gonyou wrote:

>I'm not sure if this is a Linux capabilities problem, a PAM problem, or
>what, but I've noticed that If I add a user to > 32 groups...that user
>cannot access anything in a directory owned by a group > the 32nd group.
>  
>


Yes.  It's a hardcoded limit that requires a recompile of both the 
kernel and glibc to change.

    Jeff




