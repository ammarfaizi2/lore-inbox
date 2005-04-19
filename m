Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVDSF6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVDSF6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 01:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVDSF6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 01:58:13 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:20450 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261333AbVDSF6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 01:58:04 -0400
Message-ID: <42649DD3.7040009@lab.ntt.co.jp>
Date: Tue, 19 Apr 2005 14:57:39 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42636285.9060405@lab.ntt.co.jp> <20050418075635.GB644@taniwha.stupidest.org> <20050418021609.07f6ec16.pj@sgi.com> <20050418092505.GA2206@taniwha.stupidest.org> <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp>
In-Reply-To: <426494FD.6020307@lab.ntt.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Ikebe wrote:

>Sorry, I may mistake the point,
>Chris Wedgwood wrote:
>  
>
>>that would also be a problem for live patching too, if you have bad
>>state, you have bad state --- live patching doesn't change that
>>    
>>
>What I want to say is takeover may makes memory unstable, because there
>are extra operations to reserve current (unstable) status to memory.
>Live patching never force target process to reserve status to memory. Is
>this make sense?
>  
>
Sorry, I misunderstand it, forget above comment, both methods are
possible to destroy memory.


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


