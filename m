Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWD1QSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWD1QSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWD1QSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:18:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61592 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030474AbWD1QSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:18:34 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<200604281333.41358.blaisorblade@yahoo.it>
	<20060428114823.GA3641@ccure.user-mode-linux.org>
	<200604281554.32665.blaisorblade@yahoo.it>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 28 Apr 2006 10:18:00 -0600
In-Reply-To: <200604281554.32665.blaisorblade@yahoo.it> (blaisorblade@yahoo.it's
 message of "Fri, 28 Apr 2006 15:54:31 +0200")
Message-ID: <m1wtd9d687.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> writes:

> So we get back to Eric's objection (which I haven't understood but that's my 
> problem).

My objection is that to handle the monotonic timer we need an additional
struct timespec argument when we create the time namespace.

There does not appear to be space in clone or unshare to pass that value.

Eric
