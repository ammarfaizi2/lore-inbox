Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVEELkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVEELkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVEELkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:40:19 -0400
Received: from khc.piap.pl ([195.187.100.11]:29700 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S262050AbVEELkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:40:07 -0400
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.current Oops: strace + waitpid()?
References: <m3mzrapm3w.fsf@defiant.localdomain>
	<1115280971.933.5.camel@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 05 May 2005 13:40:05 +0200
In-Reply-To: <1115280971.933.5.camel@localhost.localdomain> (Alexander
 Nyberg's message of "Thu, 05 May 2005 10:16:11 +0200")
Message-ID: <m3ekclhpey.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@telia.com> writes:

> Ok tested here, it's the ptrace scribbles the return address due to
> incorrect esp0 at fork time (it's in -mm currently).
>
> Could you please verify that this fixes it

It does.
Will you fix it is Linus' tree before 2.6.12?
Thanks.
-- 
Krzysztof Halasa
