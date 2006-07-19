Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWGSIjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWGSIjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWGSIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:39:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:31760 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932531AbWGSIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:39:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lEtw6QCqZMb0i8aqJtK+XZzwaFLjRs0y6SO45OKuoH9T9MPxjcF4/8tlSfSRYnu9ysq94b41ME3whNd1slpyzTTXOjVQ/IESZ4MUoD4GxJ9tNrVAfX32AedmVuLzygZb1Mb9tQcus6Ij9438G52oMYIfy6dIlkfFXcZzr+AlrHo=
Message-ID: <84144f020607190139h502c87abwb5fb705fb7272a0a@mail.gmail.com>
Date: Wed, 19 Jul 2006 11:39:30 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Pete Zaitcev" <zaitcev@yahoo.com>
Subject: Re: [PATCH] sound: Conversions from kmalloc+memset to k(z|c)alloc.
Cc: "Panagiotis Issaris" <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, kyle@parisc-linux.org,
       twoller@crystal.cirrus.com, James@superbug.demon.co.uk, zab@zabbo.net,
       sailer@ife.ee.ethz.ch, perex@suse.cz
In-Reply-To: <20060719024819.25960.qmail@web60412.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060719005455.GB30823@lumumba.uhasselt.be>
	 <20060719024819.25960.qmail@web60412.mail.yahoo.com>
X-Google-Sender-Auth: e3d5b70526948ffc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/06, Pete Zaitcev <zaitcev@yahoo.com> wrote:
> I can't fathom why you would want to bother. These drivers are going to
> be removed from tree anyway. Where is Adrian when you actually need him?

Agreed, but as long as they are in the tree, I don't see why not to
apply these patches.
