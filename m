Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVHKEms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVHKEms (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVHKEms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:42:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9109 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932248AbVHKEmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:42:47 -0400
Date: Wed, 10 Aug 2005 20:27:15 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: domen@coderock.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Maximilian Attems <janitor@sternwelten.at>
Subject: Re: [patch 14/16] net/tms380tr: replace direct assignment with set_current_state()
Message-ID: <20050811032715.GA4363@us.ibm.com>
References: <20050808222936.090422000@homer> <20050808223054.376836000@homer> <42FAC3A5.3010000@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FAC3A5.3010000@pobox.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.2005 [23:19:01 -0400], Jeff Garzik wrote:
> domen@coderock.org wrote:
> >From: Nishanth Aravamudan <nacc@us.ibm.com>
> >
> >
> >
> >Use set_current_state() instead of direct assignment of
> >current->state.
> >
> >Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> >Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
> >Signed-off-by: Domen Puncer <domen@coderock.org>
> 
> why?

This patch can be dropped, as -mm contains a function
(schedule_timeout_interruptible()) which makes these changes
unnecessary.

Thanks,
Nish
