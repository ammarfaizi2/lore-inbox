Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319018AbSIDCkG>; Tue, 3 Sep 2002 22:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319019AbSIDCkG>; Tue, 3 Sep 2002 22:40:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3087 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319018AbSIDCkF>;
	Tue, 3 Sep 2002 22:40:05 -0400
Message-ID: <3D75766F.1ED7257D@zip.com.au>
Date: Tue, 03 Sep 2002 19:56:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
References: <20020904023535.73D922C12D@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> Frankly, I'm amazed the kernel worked for long without this.
> 
> Every linker script thinks the section is called .data.percpu.
> Without this patch, every CPU ends up sharing the same "per-cpu"
> variable.
> 

wow.  Either this was working by fluke, or Bill's softirq problem
just got solved.
