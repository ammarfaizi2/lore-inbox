Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWEJTde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWEJTde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 15:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWEJTde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 15:33:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:37978 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751225AbWEJTdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 15:33:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YrzCkW1LkrKU7ztrXrJ5QlmEQId+35Zjyxk5U/VLWXWWFRyXXbJN8XM1l9YOeBJebqVbyhosHg8K/3anYvmdu3LokByB0yjdiP8m58y0Y2HDYqgVHMT1SxWZa8ZgNmvJ+3AWOoNYKp+T3JjF3VbVsmOEr46D+zwze+VP4YD3NHs=
Message-ID: <15ddcffd0605101233x104265adp31c3fbd13f541f96@mail.gmail.com>
Date: Wed, 10 May 2006 21:33:32 +0200
From: "Or Gerlitz" <or.gerlitz@gmail.com>
To: "Roland Dreier" <rdreier@cisco.com>
Subject: Re: [openib-general] Re: [PATCH 0/6] iSER (iSCSI Extensions for RDMA) initiator
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adak68t94g6.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0605101618360.17835-100000@zuben>
	 <adak68t94g6.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Roland Dreier <rdreier@cisco.com> wrote:
>     Or> To have this code compiled you would need to get the iscsi
>     Or> updates for 2.6.18 into your source tree, that is pull/sync
>     Or> with include/scsi and drivers/scsi of the scsi-misc-2.6 git
>     Or> tree.
>
> What is the URL of this git tree?

The URL is http://kernel.org/git/?p=linux/kernel/git/jejb/scsi-misc-2.6.git

>     Or> There's one patch which is not yet merged there and without it
>     Or> iser's compilation fails. The patch is named "iscsi: add
>     Or> transport end point callbacks" and i will send it to you
>     Or> offlist.
>
> Please let me know when it is merged.  I don't want to be merging
> iSCSI changes via my tree.

OK., I see now that as of few hours ago the second iscsi update for
2.6.18 was commited
there which means iser should compile with it, you can go ahead pull it!

Let me know if you have any issue compiling/linking iser with the
combind infiniband/scsi-misc configuration.

Cheers

   (:

       Or.
