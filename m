Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbSIZWzj>; Thu, 26 Sep 2002 18:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbSIZWyv>; Thu, 26 Sep 2002 18:54:51 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:32015 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S261553AbSIZWyA>;
	Thu, 26 Sep 2002 18:54:00 -0400
Subject: Re: using memset in a module
From: Shaya Potter <spotter@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020926.154956.109059025.davem@redhat.com>
References: <1033080562.3371.24.camel@zaphod>
	 <20020926.154956.109059025.davem@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1033081116.3371.29.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 26 Sep 2002 18:58:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 18:49, David S. Miller wrote:
>    From: Shaya Potter <spotter@cs.columbia.edu>
>    Date: 26 Sep 2002 18:49:22 -0400
> 
>    I have a problem using memset in a module.
>    
> You cannot use different compilers to build modules than
> were used to build the kernel itself.
> 
> If 2.95 was used to build the kernel, and you then try to
> use gcc-3.{0,1,2} to build a module that resulting module
> will have little chance of working.

I know that, gcc-3.2 was an act of desperation after gcc-2.95 wasn't
working at all.  I just wanted to see if it made a diff and it did,
didnt even bother try loading the resulting .o

shaya

