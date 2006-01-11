Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWAKNwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWAKNwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWAKNwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:52:31 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:35870 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751615AbWAKNwa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:52:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d0UIOquTU42XipIUFc8THxiXLj2hkdgUKfPN8mjUYgBEeqxRqTcz3zhMJ1ncOPUSnf1CPcmafqBc9xl7MRMhXCSlMxKjdbcV/WYS9rXNd/u4qyP7HLweXhVkFVSyrIiNLjng8raa4n5LLCkRY/StnmsHxWXiJ6nl00iHgTTfCYk=
Message-ID: <5a2cf1f60601110552t5e9afa0dr7785b22ae6dbd99b@mail.gmail.com>
Date: Wed, 11 Jan 2006 14:52:29 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata errors -> read-only root partition. Hardware issue?
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1136986688.28616.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5ttip-Xh-13@gated-at.bofh.it> <43C4493A.4010305@shaw.ca>
	 <5a2cf1f60601110030u358c12fcscf79067cbc3eebe0@mail.gmail.com>
	 <1136986688.28616.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2006-01-11 at 09:30 +0100, jerome lacoste wrote:
> > - scan for bad blocks
>
> Read the entire disk (write will hide and clean up errors by
> reallocating)

something like should be sufficient right?

cat /dev/sdax > /dev/null

Thanks a lot.

Jerome
