Return-Path: <linux-kernel-owner+w=401wt.eu-S1751284AbXANNqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXANNqt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 08:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbXANNqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 08:46:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:19425 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbXANNqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 08:46:48 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RFMJ3MqgObkzroc+OmfK5wsQ7LgtgkFfy2WbzLmwrizxVmiMYMZ3zulF3yVt1nfnr7ALV5b2o8KZ+VLzbFTQy37cfJSQ5JC80FHJSrdvnCoG7VKQRA9Mo1UfAjArROGq4GJ0T8VNvf0UZ1DwY5hqAPc3mmvDqJI9RHvoNqKWY8c=
Message-ID: <b6a2187b0701140546ne0b95d8q7aff70d93ffabb9@mail.gmail.com>
Date: Sun, 14 Jan 2007 21:46:46 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: Linux v2.6.20-rc5
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <20070114125648.GV7469@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701141858490.7122@boston.corp.fedex.com>
	 <20070114125648.GV7469@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/07, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Jan 14, 2007 at 07:03:12PM +0800, Jeff Chua wrote:
> >
> > On 1/14/07, Adrian Bunk <bunk@stusta.de> wrote:
> > >On Sun, Jan 14, 2007 at 03:38:24PM +0800, Jeff Chua wrote:
> > >>
> > >> setting CONFIG_PARAVIRT=y will return in ...
> > >>
> > >>       vmmon.ko module unknown symbol paravirt_ops

> Could it be you compiled the module against a CONFIG_PARAVIRT=y tree and
> tried to use it with a (CONFIG_PARAVIRT=n kernel?

I recompiled the vmmon module under the new kernel with
CONFIG_PARAVIRT=y. It compiled fine, but when loaded, it gives the
unknown symbol warning. I shalll make it clear that this is not a
kernel issue ... it's just vmware, but I don't know how to fix it, and
needed help from the experts.

Thanks,
Jeff.
