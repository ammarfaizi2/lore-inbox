Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVDREmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVDREmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 00:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVDREmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 00:42:38 -0400
Received: from nevyn.them.org ([66.93.172.17]:4232 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261654AbVDREmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 00:42:31 -0400
Date: Mon, 18 Apr 2005 00:42:23 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050418044223.GB15002@nevyn.them.org>
Mail-Followup-To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>,
	Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263356D.9080007@lab.ntt.co.jp>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
> GDB based approach seems not fit to our requirements. GDB(ptrace) based 
> functions are basically need to be done when target process is stopping.
> In addition to that current PTRACE_PEEK/POKE* allows us to copy only a 
> *word* size...

While true, this is easily fixable.  There is even an interface
precedent on OpenBSD (and possibly other platforms as well).

-- 
Daniel Jacobowitz
CodeSourcery, LLC
