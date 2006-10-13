Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWJMF4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWJMF4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 01:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWJMF4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 01:56:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:47447 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751048AbWJMF4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 01:56:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=t/32S4Ioyjg7WJZM+yCsR4SzRLoUM8CScy6VnQKqL8Yx5yPHIVubXi8gSoRBjXtZ/rNr7LeN0ZzbLU/TiMcfrRGn/kmQlhXZRxoap3ewUr0z93b2v1Fd1tA4GlqOP/puYJz5SDi/kTMrP3g8TryCDudrt1jc548Ix/M24j96HJ0=
Message-ID: <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
Date: Fri, 13 Oct 2006 08:56:16 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "nmeyers@vestmark.com" <nmeyers@vestmark.com>
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
Cc: linux-kernel@vger.kernel.org,
       "Catalin Marinas" <catalin.marinas@gmail.com>
In-Reply-To: <20061013004918.GA8551@viviport.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013004918.GA8551@viviport.com>
X-Google-Sender-Auth: 0b1045163cafbfb5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/06, nmeyers@vestmark.com <nmeyers@vestmark.com> wrote:
> If anyone has a version of kmemleak that I can build with 4.1.1, or
> any other suggestions for instrumentation, I'd be happy to gather more
> data - the problem is very easy for me to reproduce.

You should cc Catalin for that. Alternatively, you could try
CONFIG_DEBUG_SLAB_LEAK.
