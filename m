Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVFBTEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFBTEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 15:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVFBTEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 15:04:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29828 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261245AbVFBTD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 15:03:59 -0400
Date: Thu, 2 Jun 2005 15:03:50 -0400
From: Dave Jones <davej@redhat.com>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5 is broken in nvidia Ck804 Opteron MB/with dual cor e dual way
Message-ID: <20050602190350.GD18775@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, YhLu <YhLu@tyan.com>,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <3174569B9743D511922F00A0C94314230A403970@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C94314230A403970@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 11:56:25AM -0700, YhLu wrote:
 > Really?,  smp_num_siblings is global variable and initially is set 1.

Why shouldn't it be ? It would only make sense to make it
non-global if we supported a configuration where different
CPUs had different numbers of siblings, which we don't.
(And I'm fairly sure that AMD/Intel don't/won't either)

		Dave

