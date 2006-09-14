Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWINXvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWINXvT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWINXvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:51:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63121 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932139AbWINXvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:51:18 -0400
Date: Thu, 14 Sep 2006 16:51:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Subject: Re: [PATCH 0/7] Integrity Service and SLIM
Message-Id: <20060914165113.3067c4b0.akpm@osdl.org>
In-Reply-To: <1158083845.18137.10.camel@localhost.localdomain>
References: <1158083845.18137.10.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006 10:57:25 -0700
Kylene Jo Hall <kjhall@us.ibm.com> wrote:

> This is an updated request for comments on a proposed integrity 
> service framework and dummy provider, along with SLIM, a low 
> water-mark mandatory access control LSM module which utilizes the 
> integrity services as additional input to the access control decisions.

Having carefully reviewed your code I have come to the firm conclusion that
it is written in C.  The next step is to put it all in -mm and see if
anyone shouts at me.

I'll need help on the upstream-merge decision.

A convincing statement of interest (or, better, intent) from vendors (ie:
the people who will deliver and support this into the target users) would
help a lot.  Where do we stand with that?

Thanks.

