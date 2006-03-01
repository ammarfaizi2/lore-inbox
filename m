Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWCADms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWCADms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWCADms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:42:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750964AbWCADmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:42:47 -0500
Date: Tue, 28 Feb 2006 19:42:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228194243.198e1ec6.akpm@osdl.org>
In-Reply-To: <44051562.8070708@yahoo.com.au>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<6bffcb0e0602280701h1d5cbeaar@mail.gmail.com>
	<6bffcb0e0602280820ic87332k@mail.gmail.com>
	<440503E5.1070100@yahoo.com.au>
	<20060228184450.dd831456.akpm@osdl.org>
	<4405108B.4050701@yahoo.com.au>
	<20060228192115.473673ab.akpm@osdl.org>
	<44051562.8070708@yahoo.com.au>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> 
> I can reproduce a similar looking oops by unlinking a PARENT_WATCHED file, then
> touching it again.
> 

Oh, OK.

What does a patch which clears that flag on the -ve dentry look like?  I
think it'd be best to be paranoid at this stage..
