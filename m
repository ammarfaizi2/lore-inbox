Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262760AbTCVRAm>; Sat, 22 Mar 2003 12:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262898AbTCVRAm>; Sat, 22 Mar 2003 12:00:42 -0500
Received: from holomorphy.com ([66.224.33.161]:62099 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262760AbTCVRAm>;
	Sat, 22 Mar 2003 12:00:42 -0500
Date: Sat, 22 Mar 2003 09:11:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RPCSVC_MAXPAGES doesn't account for overhead(?) pages
Message-ID: <20030322171129.GD30140@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303221116250.18911-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0303221152060.18911-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303221152060.18911-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 11:52:44AM -0500, Zwane Mwaikambo wrote:
> I forgot the patch...
> -#define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE + 1)
> +#define RPCSVC_MAXPAGES		(2+((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE+1))


This looks fine to me. Applied, thanks.


-- wli
