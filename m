Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSGQRkO>; Wed, 17 Jul 2002 13:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSGQRkO>; Wed, 17 Jul 2002 13:40:14 -0400
Received: from holomorphy.com ([66.224.33.161]:26759 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315941AbSGQRkM>;
	Wed, 17 Jul 2002 13:40:12 -0400
Date: Wed, 17 Jul 2002 10:43:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Burton Windle <bwindle@fint.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.26] Reproducable oops with X Font Server
Message-ID: <20020717174306.GH1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Burton Windle <bwindle@fint.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.43.0207171311150.7414-100000@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0207171311150.7414-100000@morpheus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 01:23:36PM -0400, Burton Windle wrote:
> Unable to handle kernel paging request at virtual address 5a5a5ace

This looks like slab poison.


>>EIP; c011083f <schedule+1b7/2b4>   <=====

Any chance you can run addr2line on that?



Thanks,
Bill
