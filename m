Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWEYKny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWEYKny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWEYKny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:43:54 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:14230 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965114AbWEYKnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:43:53 -0400
Message-ID: <348553829.15436@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 25 May 2006 18:43:53 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] readahead: state based method - data structure
Message-ID: <20060525104353.GF4996@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060524111246.420010595@localhost.localdomain> <348469542.39504@ustc.edu.cn> <447548B3.2000203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447548B3.2000203@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 04:03:31PM +1000, Nick Piggin wrote:
> Wu Fengguang wrote:
> 
> >Extend struct file_ra_state to support the adaptive read-ahead logic.
> >
> 
> Another nitpick: It is usually OK to do these things in the same patch
> that actually uses the new data (or functions -- eg. patch 15).
> 
> If the addition is complex or in a completely different subsystem
> (eg. your rescue_pages function), _that_ can justify it being split
> into its own patch. Then you might also prepend the subject with mm:
> and cc linux-mm to get better reviews.

Ok, thanks for the advice.

Regards,
Wu
