Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVDTIAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVDTIAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVDTIAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:00:00 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:48115 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261465AbVDTH73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:59:29 -0400
Message-ID: <42660B6B.6040600@lab.ntt.co.jp>
Date: Wed, 20 Apr 2005 16:57:31 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Rik van Riel <riel@redhat.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
References: <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4263AD94.0@lab.ntt.co.jp> <Pine.LNX.4.61.0504181001470.8456@chimarrao.boston.redhat.com> <42646983.4020908@lab.ntt.co.jp> <20050419042720.GA15123@taniwha.stupidest.org> <426494FD.6020307@lab.ntt.co.jp> <20050419055254.GA15895@taniwha.stupidest.org> <4265D80F.6030007@lab.ntt.co.jp> <20050420054352.GA7329@taniwha.stupidest.org> <4266062B.9060400@lab.ntt.co.jp> <20050420075031.GA31785@taniwha.stupidest.org>
In-Reply-To: <20050420075031.GA31785@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Apr 20, 2005 at 04:35:07PM +0900, Takashi Ikebe wrote:> 
> 
>>To takeover the application status, connection type
>>communications(SOCK_STREAM) are need to be disconnected by close().
>>Same network port is not allowed to bind by multiple processes....
> 
> 
> AF_UNIX socket with SCM_RIGHTS
> 
hmm.. most internet base services will use TCPv4 TCPv6 SCTP...
AF_UNIX can not use as inter-nodes communication.


-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp
