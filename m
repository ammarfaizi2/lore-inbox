Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWI2JgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWI2JgW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWI2JgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:36:22 -0400
Received: from gw.goop.org ([64.81.55.164]:52190 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932091AbWI2JgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:36:21 -0400
Message-ID: <451CE921.5010002@goop.org>
Date: Fri, 29 Sep 2006 02:36:33 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
References: <20060928225444.439520197@goop.org>	<20060928225452.229936605@goop.org> <20060929021604.02fb6162.akpm@osdl.org>
In-Reply-To: <20060929021604.02fb6162.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I think we need to thank the powerpc guys, then take away their function
> name printing ;)
>   

Also, I think !CONFIG_DEBUG_BUGVERBOSE shouldn't store anything other 
than the ud2a instructions, to keep the embedded people happy.

    J

