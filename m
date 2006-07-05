Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWGESot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWGESot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWGESot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:44:49 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:16000 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964944AbWGESos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:44:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lOLVoHZDmeC9ruBPjnwZVyjimPV8u7tquLgjmk8V8DHjzc9WYsApJW3nvp7gy3LIGR+t91uv380w9vXsg4rI4GDLOPgQ/Kdo1FnaB+Fjt/trEdYjhiFwl9PUCDYWruqhPCjTgdxOJE7q07sGzByfxn0Lz5HH9gjoIaVCtfUisFM=
Message-ID: <a44ae5cd0607051144w5734ce4bkd38320adda99ae43@mail.gmail.com>
Date: Wed, 5 Jul 2006 11:44:47 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Petko Manolov" <petkan@users.sourceforge.net>
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Cc: linux-kernel@vger.kernel.org, "David Brownell" <david-b@pacbell.net>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060703121717.b36ef57e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com>
	 <20060703014016.9f598cef.akpm@osdl.org>
	 <a44ae5cd0607030704q63f1f64x5e46688cef6fa44c@mail.gmail.com>
	 <20060703121717.b36ef57e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petko,

David Brownell pointed out that you are the author of this driver (rtl8150).
My laptop is crashing every time I remove the Linksys EtherFast 10/100
Compact Network Adapter (model USB100M) from the USB port.

Here's a link to the discussion thus far:
http://groups.google.com/group/linux.kernel/tree/browse_frm/thread/8c93e310c7b71242/a8a1e3edb1601906?rnum=1&q=miles+lane&_done=%2Fgroup%2Flinux.kernel%2Fbrowse_frm%2Fthread%2F8c93e310c7b71242%2Fc8a8ba47c49c39fc%3Ftvc%3D1%26q%3Dmiles+lane%26#doc_a8a1e3edb1601906

Here's the stacktrace:
http://www.zip.com.au/~akpm/linux/patches/stuff/00003.jpg

I have reproduced the bug with vanilla 2.6.17.  I am currently working my
back through kernel versions to try to isolate the responsible patches.

         Miles
