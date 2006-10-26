Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965247AbWJZAyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965247AbWJZAyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 20:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWJZAyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 20:54:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:25207 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965247AbWJZAyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 20:54:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hd+P98yQ7KGFClW4WpaK3bh7N5LpeAQmooHut0Ct6rUwg+TspjgadERzXP3Hq+0HRGXlHQfg26HMhTum/5/Q+7QsRI/InylFdzSsTsTUVOf/i0drvxKXh1j+KepIYG9URYcOe0r0fNJ9Swkze1hRIsTadliAGrYLF4vt9XxZSts=
Message-ID: <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com>
Date: Thu, 26 Oct 2006 08:54:12 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: linux-2.6.19-rc2 tg3 problem
Cc: linux-kernel@vger.kernel.org, "David Miller" <davem@davemloft.net>
In-Reply-To: <20061025013022.GG27968@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com>
	 <20061025013022.GG27968@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Oct 23, 2006 at 11:24:14PM +0800, Jeff Chua wrote:
> > I'm getting this error on with linux 2.6.19-rc2 with tg3 module, even
> > with patching to v3.66 ...
> > The last version 2.6.18-rc2 works fine. h/w is Dell Optiplex GX620.
>
> Known issue, can you confirm the patches below fix it for you?

I see the patch is for x86_64. I'm on 32bit. And tg3 is compiled as a
module, so I can't pass pci=routeirq to it. Tried on boot cmdline, but
doesn't work.

I've tried 2.6.19-rc3, still the same problem.

Thanks,
Jeff.
