Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317113AbSEXILY>; Fri, 24 May 2002 04:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSEXILX>; Fri, 24 May 2002 04:11:23 -0400
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:20996 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S317113AbSEXILW>; Fri, 24 May 2002 04:11:22 -0400
Date: Fri, 24 May 2002 10:11:22 +0200
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ww@kt.e-technik.uni-dortmund.de, linux-kernel@vger.kernel.org
Subject: Re: sk_buff misunderstanding?
Message-ID: <20020524101122.C1778@bigmac.e-technik.uni-dortmund.de>
In-Reply-To: <20020524100434.B1778@bigmac.e-technik.uni-dortmund.de> <20020524.005259.36212462.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 12:52:59AM -0700, David S. Miller wrote:
> 
> If you don't copy your new sk_buff members at skb_copy and
> skb_clone time, nobody will ever see them.
thanks, David...

I forgot to mention that I do initialize the values in alloc_skb
and skb_headerinit, and copy them in skb_clone and copy_skb_header

Are there any more occurrences?

Wolfgang

