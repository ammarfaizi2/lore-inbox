Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVBNTPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVBNTPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 14:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVBNTPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 14:15:16 -0500
Received: from colin2.muc.de ([193.149.48.15]:51720 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261528AbVBNTPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 14:15:10 -0500
Date: 14 Feb 2005 20:15:09 +0100
Date: Mon, 14 Feb 2005 20:15:09 +0100
From: Andi Kleen <ak@muc.de>
To: Robin Holt <holt@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050214191509.GA56685@muc.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <20050212155426.GA26714@logos.cnet> <20050212212914.GA51971@muc.de> <20050214163844.GB8576@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050214163844.GB8576@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But how do you use mbind() to change the memory placement for an anonymous
> private mapping used by a vendor provided executable with mbind()?

For that you use set_mempolicy.

-Andi
