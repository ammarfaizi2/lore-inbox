Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVDTIwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVDTIwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVDTIwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:52:12 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:64254 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261481AbVDTIwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:52:09 -0400
Date: Wed, 20 Apr 2005 01:51:26 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050420085126.GA3263@taniwha.stupidest.org>
References: <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org> <4266062B.9060400@lab.ntt.co.jp> <20050420075031.GA31785@taniwha.stupidest.org> <42660B6B.6040600@lab.ntt.co.jp> <20050420082655.GA2756@taniwha.stupidest.org> <4266168C.7050301@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4266168C.7050301@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 05:45:00PM +0900, Takashi Ikebe wrote:

> Only for AF_UNIX..

I'm sure that means AF_UNIX is restricted for the socket you use to
pass the file descriptors, not a restriction on the file descriptors
themselves.  I don't see why the kernel would care what the
descriptors are.

> Well, as many said Live patching is very historical & authoritative
> function on especially carrier, telecom vendor.

Linux doesn't have it now, do it's not historical in the Linux space.

> If linux want to be adopted on mission critical world, this function
> is esseintial.

But Linux is used in mission critical places and we don't have that
feature.
