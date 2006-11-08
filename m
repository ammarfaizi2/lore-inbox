Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754477AbWKHJ0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbWKHJ0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 04:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbWKHJ0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 04:26:12 -0500
Received: from mx.go2.pl ([193.17.41.41]:25568 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1754474AbWKHJ0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 04:26:10 -0500
Date: Wed, 8 Nov 2006 10:32:01 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: INFO alpha CPU: Locking API testsuite: Results kernel 2.6.18.1
Message-ID: <20061108093201.GA2489@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454CA335.609@steudten.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-11-2006 15:27, alpha @ steudten Engineering wrote:
> kernel-2.6.18.1 ALPHA SX164
> No "failed" on x86.
> ------------------------
> | Locking API testsuite:
> ----------------------------------------------------------------------------
>                                  | spin |wlock |rlock |mutex | wsem | rsem |
>   --------------------------------------------------------------------------
>                      A-A deadlock:failed|failed|  ok  |failed|failed|failed|
...
> --------------------------------------------------------
> 143 out of 218 testcases failed, as expected. |
> ----------------------------------------------------

CONFIG_PROVE_LOCKING=y ?

Jarek P.
