Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968424AbWLEQXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968424AbWLEQXU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968427AbWLEQXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:23:20 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:36824 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968424AbWLEQXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:23:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hyhXksVV5YJW4f0CNkmk36kItLpC4XA82gSFS3baq2gevTx6NVPjM1n17W0ffh3qFbGzs1GBjm6dgeVLuavXeT42OJlNQ+rB4Vpe0zd1gnSKGpwqwcVWpObvZBXlI87461P1rOlRoS4CE6hheA32DqzGxj6vfGiO4hZUHjjTjNo=
Message-ID: <5d96567b0612050823n225d4c43j35c7210e228d26@mail.gmail.com>
Date: Tue, 5 Dec 2006 18:23:17 +0200
From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: slow io_submit
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-aio@kvack.org
In-Reply-To: <45744101.2040904@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5d96567b0612010904s361b799t8db72accc287ca54@mail.gmail.com>
	 <20061201172749.GZ5400@kernel.dk>
	 <5d96567b0612011340m410a2294w9b02b619a62888da@mail.gmail.com>
	 <45744101.2040904@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> Raz Ben-Jehuda(caro) wrote:
> > Who returns EGAIN to whom ?   I am not sure i understand what you mean
> > here.
>
> If the queue is full then io_sumbit() should return EAGAIN or some other
> error to indicate that the queue is full, but right now it just blocks
> instead.
>
thanks Phiilip
But... hmmm ... should'nt an asynchronous operation act as
"send and forget" . isn't  "queue full" a problem that aio must at
least try and handle before returning to the user ?

-- 
Raz
