Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266720AbUG0X1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266720AbUG0X1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUG0X1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:27:30 -0400
Received: from holomorphy.com ([207.189.100.168]:17287 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266720AbUG0X13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:27:29 -0400
Date: Tue, 27 Jul 2004 16:27:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040727232724.GH2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	raul@pleyades.net, linux-kernel@vger.kernel.org
References: <20040727083947.GB31766@DervishD> <20040727160057.GE2334@holomorphy.com> <20040727171025.GA26146@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727171025.GA26146@DervishD>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> dixit:
>> Probably best to implement timeouts by hand in your network daemon.

On Tue, Jul 27, 2004 at 07:10:25PM +0200, DervishD wrote:
>     Of course, this is a bug in the application, but anyway the
> kernel (IMHO) shouldn't allow this.

I suspect the sysctls controlling this, tcp_fin_timeout, tcp_max_orphans,
etc., may be useful to you. Check Documentation/networking/ip-sysctl.txt


-- wli
