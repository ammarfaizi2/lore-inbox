Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282814AbRK0GYB>; Tue, 27 Nov 2001 01:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282815AbRK0GXt>; Tue, 27 Nov 2001 01:23:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60677 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282814AbRK0GXh>; Tue, 27 Nov 2001 01:23:37 -0500
Message-ID: <3C03315C.5060203@zytor.com>
Date: Mon, 26 Nov 2001 22:23:24 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Nathan Myers <ncm-nospam@cantrip.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] omnibus header cleanup, certification
In-Reply-To: <20011127061714.A41881@cantrip.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Myers wrote:

>> 
> Please review at least the portion that you are responsible for,
> and verify that the changes are safe and cannot change the semantics 
> of otherwise-correct code that uses the affected macros.  (That will
> be easy, they're all trivial parenthesizations.  It seems worth noting 
> here that in the C grammar, "-1" is not a numeric literal, but a unary 
> expression.)  Then, pass on your evaluation to Linus and Marcelo.  
> 


It's also worth noting that there is nothing that it can get confused 
with and still have a compilable expression.

I don't believe the unary-expression patches are necessary.  They are, 
of course, harmless, except for the fact that my eyes glazed over 
staring at page after page of these, which very few actual potential (!) 
bugs (there were a couple, like the iopage+ ones...)

	-hpa

