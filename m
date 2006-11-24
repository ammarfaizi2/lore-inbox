Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934444AbWKXSqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934444AbWKXSqG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935000AbWKXSqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:46:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:29957 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934444AbWKXSqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:46:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=IJBcC7jo0lR3ecvdJzSO4OpA83pyaRorGAf9+rTEzdEExmN0gbLMDaYnsSxWwIW8HOhl0iMYtsuv/EGhxf0HgSQuk7BCc+si1nGmZgqo1EoQm8nmUZ8V+FHuPqtFu72Ectdz4Y0diUYtVL0sYMHH8GGGByP2xTwVvcEXZ0NW7KM=
Message-ID: <86802c440611241046o5c8e0b88r8cc07489ebb28446@mail.gmail.com>
Date: Fri, 24 Nov 2006 10:46:00 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andrew Morton" <akpm@osdl.org>, "Greg KH" <greg@kroah.com>
Subject: Re: PCI: check szhi when sz is 0 when 64 bit iomem bigger than 4G
Cc: "Greg KH" <gregkh@suse.de>, "Andi Kleen" <ak@suse.de>,
       linux-kernel@vger.kernel.org, myles@mouselemur.cs.byu.edu
In-Reply-To: <20061123083920.GA21211@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA4130683@ssvlexmb2.amd.com>
	 <20061123083920.GA21211@kroah.com>
X-Google-Sender-Auth: fc38977524b6eb6e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 06, 2006 at 07:29:24PM -0800, Lu, Yinghai wrote:
> > [PATCH] PCI: check szhi when sz is 0 when 64 bit iomem bigger than 4G
> I'm dropping this patch, as the compiler warnings show that something is
> still wrong here.

Andrew,

Can you send out that revised patch out to the list?

Thanks

YH
