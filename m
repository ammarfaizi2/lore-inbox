Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318038AbSIESns>; Thu, 5 Sep 2002 14:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSIESns>; Thu, 5 Sep 2002 14:43:48 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:11015 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318038AbSIESnr>; Thu, 5 Sep 2002 14:43:47 -0400
Date: Thu, 5 Sep 2002 19:48:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905194824.A11974@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905184125.GA1657@dualathlon.random>; from andrea@suse.de on Thu, Sep 05, 2002 at 08:41:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 08:41:25PM +0200, Andrea Arcangeli wrote:
> other fs, if you're not holding the i_sem (and you certainly aren't
> holding the i_sem that frequently, you don't even for writes).

Except of O_DIRECT writes we _do_ hold i_sem, btw.

