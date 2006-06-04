Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751495AbWFDO3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWFDO3Z (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 10:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWFDO3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 10:29:25 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:56814 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751495AbWFDO3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 10:29:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KUfc8eiQWoXzw4ghzLA60jFAroU6P7lmaQo8gsYq1aQIbNYuRVISkqS59+0b7aVeS1cJ7cfQJsJWjREaUqaBeZsaAWcWJT5hgRDt7K/RQX1OqMxXK8L4aEiigOOsCkMyb5n49n9NpyMc2Zue6g423uYcLsNlAnqjKwwUDidkJWw=
Message-ID: <beee72200606040729u4c660583g1b7e669b85db5bca@mail.gmail.com>
Date: Sun, 4 Jun 2006 16:29:24 +0200
From: "davor emard" <davoremard@gmail.com>
To: "Con Kolivas" <kernel@kolivas.org>
Subject: Re: SMP HT + USB2.0 crash
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606042142.01879.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
	 <200606042142.01879.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested this _A_LOT_ and it doesn't matter if I
use "nvidia" binary drivers or x.org's free "nv" or
have just a text console with no X at all.
It happens on a production machine :(

Most easily to trigger this bug is to use USB2.0 epson
scanner over and have scanbuttond running - it will poll
scan buttons via usb2.0 and crash

On 6/4/06, Con Kolivas <kernel@kolivas.org> wrote:
> On Sunday 04 June 2006 20:22, davor emard wrote:
> > Usually SMP + EHCI crashes like this
>
> Unless you can reproduce your crash without binary only drivers such as the
> nvidia one your bug report cannot be acted upon.
>
> --
> -ck
>
