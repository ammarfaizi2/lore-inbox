Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWGDMHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWGDMHO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWGDMHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:07:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:21633 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932216AbWGDMHM (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:07:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HCDqacbWYGTrCkFbDxj203iiv3GsPcyywdprBuOW6al23DGFL3rxtuGAu9tL/bO+EiGyOCXUFwOmCpsQ2kbAZx8u4YIWyPLpUe1KSrovhdDpHK2tFQJuvU79u1BUYoG2LoU8C8znUw3q+aXTzSSpur6n+ICEBd6joNbHQ241CVc=
Message-ID: <84144f020607040507u58489b8eqfe8f41ef0d76b369@mail.gmail.com>
Date: Tue, 4 Jul 2006 15:07:11 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Subject: Re: [PATCH 1/2] batch-write.patch
Cc: "Andrew Morton" <akpm@osdl.org>, lkml <Linux-Kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com
In-Reply-To: <1152012117.6454.41.camel@tribesman.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44A42750.5020807@namesys.com>
	 <20060629185017.8866f95e.akpm@osdl.org>
	 <1152011576.6454.36.camel@tribesman.namesys.com>
	 <1152012117.6454.41.camel@tribesman.namesys.com>
X-Google-Sender-Auth: ed73a2a0f3c2ad82
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/06, Vladimir V. Saveliev <vs@namesys.com> wrote:
> @@ -784,6 +786,8 @@ otherwise noted.
>
>    writev: called by the writev(2) system call
>
> +  batch_write: optional, if implemented called by writev(2) and write(2)
> +

It'd be nice if you added some explanation here why a filesystem
developer would want to implement it.

                                       Pekka
