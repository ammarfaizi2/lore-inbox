Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVBARgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVBARgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVBARgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:36:32 -0500
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:64490 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S262078AbVBARg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:36:26 -0500
Date: Tue, 1 Feb 2005 18:36:24 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050201173622.GA1206@stilzchen.informatik.tu-chemnitz.de>
References: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131162201.GA1000@stilzchen.informatik.tu-chemnitz.de>
User-Agent: Mutt/1.5.6+20040907i
From: Mirko Parthey <mirko.parthey@informatik.tu-chemnitz.de>
X-Scan-Signature: 0e3fbd3f50959cf49c69ab43e98fd2b3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 05:22:02PM +0100,  wrote:
> My Debian machine hangs during shutdown, with messages like this:
> unregister_netdevice: waiting for br0 to become free. Usage count = 1
> 
> I narrowed it down to the command
>   # brctl delbr br0
> which does not return in the circumstances shown below.
> 
> The problem is reproducible with both 2.6.11-rc2 from kernel.org and the
> Debian kernel-image-2.6.10-1-686.
> [...]

The problem was introduced between 2.6.8.1 and 2.6.9,
and it is still present in 2.6.11-rc2-bk9.

Mirko
