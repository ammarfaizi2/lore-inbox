Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVDTFoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVDTFoQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 01:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVDTFoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 01:44:16 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:42402 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261405AbVDTFoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 01:44:11 -0400
X-ORBL: [67.124.119.21]
Date: Tue, 19 Apr 2005 22:43:52 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050420054352.GA7329@taniwha.stupidest.org>
References: <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4265D80F.6030007@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2005 at 01:18:23PM +0900, Takashi Ikebe wrote:

> Well, Live patching is just a patch, so I think the developer of
> patch should know the original source code well.

In which case they could fix the application.

> Well, as you said some application can do that, but some application
> can not continue service with your suggestion.

Such as?

> please think about the process which use connection type
> communication such as TCP(it's only example) between users and
> server. During status copy, all the session between users and server
> are disconnected...

They don't have to be.

> can not save the exiting service at all.

Yes they can.

> It's one example, but similar problems may occurs whenever processed
> use the resources which are mainly controlled by kernel.

What resources?  We can migrate memory and file descriptors?  What is
missing?

Anyhow, you seem hell bent on this despite showing any real evidence
it's useful or desirable...  maybe a different audience for your
patches would help?

http://selenic.com/mailman/listinfo/kernel-mentors might be of value
to you.

