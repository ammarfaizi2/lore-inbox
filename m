Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbVKIOf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbVKIOf7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVKIOf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:35:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8664 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751368AbVKIOf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:35:58 -0500
Date: Wed, 9 Nov 2005 15:35:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@hill9.org,
       wli@holomorphy.com
Subject: Re: [PATCH] tasklist-RCU fix in attach_pid()
Message-ID: <20051109143538.GA12399@elte.hu>
References: <20051109032233.GA3060@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109032233.GA3060@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> Bug in attach_pid() can result in RCU readers in find_pid() getting
> confused if they race with process creation.
> 
> Signed-off-by: <paulmck@us.ibm.com>

yeah ...

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
