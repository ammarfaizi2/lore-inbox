Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422665AbWASX1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWASX1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWASX1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:27:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422665AbWASX07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:26:59 -0500
Date: Thu, 19 Jan 2006 15:27:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: 3c59x went nuts between .15-mm3 and .15-mm4
Message-Id: <20060119152757.6d7f3924.akpm@osdl.org>
In-Reply-To: <20060119223114.GN16047@bayes.mathematik.tu-chemnitz.de>
References: <20060119225345.18a570ae@werewolf.auna.net>
	<20060119223114.GN16047@bayes.mathematik.tu-chemnitz.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Klassert <klassert@mathematik.tu-chemnitz.de> wrote:
>
> The driver version did not increase since more than three years.
> But perhaps it is a good idea to maintain the driver version. 

Just nuke it.  Per-driver versioning is pretty meaningless and we should
and do identify driver versions by the version of the top-level kernel
which contains them.
