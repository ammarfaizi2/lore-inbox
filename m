Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWIYG3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWIYG3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWIYG3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:29:30 -0400
Received: from gw.goop.org ([64.81.55.164]:26012 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932203AbWIYG33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:29:29 -0400
Message-ID: <4517774F.9010806@goop.org>
Date: Sun, 24 Sep 2006 23:29:35 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: i386 pda patches
References: <20060924013521.13d574b1.akpm@osdl.org>	<4517256E.10606@goop.org>	<20060924223427.6f42e77c.akpm@osdl.org>	<45176B53.7040608@goop.org> <20060924230506.572eee8e.akpm@osdl.org>
In-Reply-To: <20060924230506.572eee8e.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It oopses in the same manner with 4k stacks enabled.
>   

Hm. Looks like its the actual load_TR_desc() getting the GPF. I'm 
updating the patches to 2.6.18-mm1, and I'll try to repro this.

Have there been any other oops reports for -mm which look like this? Is 
there anything unusual about the config?

J
