Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbTAOBGH>; Tue, 14 Jan 2003 20:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbTAOBGH>; Tue, 14 Jan 2003 20:06:07 -0500
Received: from are.twiddle.net ([64.81.246.98]:46728 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265643AbTAOBGF>;
	Tue, 14 Jan 2003 20:06:05 -0500
Date: Tue, 14 Jan 2003 17:14:57 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, davem@vger.kernel.org
Subject: Re: [module-init-tools] fix weak symbol handling
Message-ID: <20030114171457.E5751@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, davem@vger.kernel.org
References: <20030113110457.A936@twiddle.net> <20030114032138.7B1482C40D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114032138.7B1482C40D@lists.samba.org>; from rusty@rustcorp.com.au on Tue, Jan 14, 2003 at 02:16:57PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 02:16:57PM +1100, Rusty Russell wrote:
> So the semantics you want are that if A declares a weak symbol S, and
> B exports a (presumably non-weak) symbol S, then A depends on B?

No.  The semantics I need is if A references a weak symbol S 
and *no one* implements it, then S resolves to NULL.


r~
