Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268405AbTCCHcO>; Mon, 3 Mar 2003 02:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTCCHcO>; Mon, 3 Mar 2003 02:32:14 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:63236 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268405AbTCCHcN>; Mon, 3 Mar 2003 02:32:13 -0500
Date: Mon, 3 Mar 2003 07:42:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][CHECKER] i2c-core locking
Message-ID: <20030303074238.A23510@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303022325400.25240-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.50.0303022325400.25240-100000@montezuma.mastecende.com>; from zwane@linuxpower.ca on Sun, Mar 02, 2003 at 11:26:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 11:26:29PM -0500, Zwane Mwaikambo wrote:
> This one looks like it wasn't dropping the driver mutex on some exit 
> paths.

Please leave this as-is for now.  lm_sensors CVS has replaced the two
with a single semaphore and I plan to bring their changes over to
mainline soon.

