Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVJaJA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVJaJA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVJaJA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:00:27 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54509 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932296AbVJaJA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:00:26 -0500
From: Junio C Hamano <junkio@cox.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: linux-kernel@vger.kernel.org, Rob Landley <rob@landley.net>
Subject: Re: [git patches] 2.6.x libata updates
References: <20051029182228.GA14495@havoc.gtf.org>
	<200510301731.47825.rob@landley.net>
	<Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
	<200510302035.26523.rob@landley.net>
	<7v7jbujfh6.fsf@assigned-by-dhcp.cox.net>
	<20051029182228.GA14495@havoc.gtf.org>
	<200510301731.47825.rob@landley.net>
	<Pine.LNX.4.64.0510301654310.27915@g5.osdl.org>
	<200510302035.26523.rob@landley.net>
	<7v7jbujfh6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0510302353370.16065@qynat.qvtvafvgr.pbz>
Date: Mon, 31 Oct 2005 01:00:24 -0800
In-Reply-To: <Pine.LNX.4.62.0510302353370.16065@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Mon, 31 Oct 2005 00:10:47 -0800 (PST)")
Message-ID: <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> writes:

> given the time required to compile a kernel and reboot you can't plan to 
> keep the info server side (browser connections will time out well before 
> this finishes)
>
> instead this will require saving something on the client and passing it 
> back to the server.

I was thinking about doing thatn in hidden input fields and
passing form back and forth.  After all what real git bisect
keeps locally are one bad commit ID and bunch of good commit
IDs.

