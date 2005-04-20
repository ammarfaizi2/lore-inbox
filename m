Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVDTLUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDTLUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVDTLUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:20:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50092 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261498AbVDTLUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:20:11 -0400
Date: Wed, 20 Apr 2005 07:19:33 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
cc: Chris Wedgwood <cw@f00f.org>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
In-Reply-To: <4266168C.7050301@lab.ntt.co.jp>
Message-ID: <Pine.LNX.4.61.0504200718570.23123@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com>
 <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org>
 <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org>
 <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org>
 <4266062B.9060400@lab.ntt.co.jp> <20050420075031.GA31785@taniwha.stupidest.org>
 <42660B6B.6040600@lab.ntt.co.jp> <20050420082655.GA2756@taniwha.stupidest.org>
 <4266168C.7050301@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005, Takashi Ikebe wrote:

> Well, as many said Live patching is very historical & authoritative
> function on especially carrier, telecom vendor.
> If linux want to be adopted on mission critical world, this function is
> esseintial.

Yes, if you want to use Linux in those scenarios you will
need to change the telco programs to use shared memory and
file descriptor passing, instead of live patching.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
