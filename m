Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVK3LFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVK3LFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 06:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVK3LFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 06:05:10 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:46969 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750986AbVK3LFK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 06:05:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NiqZYRhmY++3yG7qZGoy9ThQkqD3846Zwyf8m2nbVbPq4lfRiEVunBBGCpu4yqXErnM5hWyqrb0KSSGpaRVBU20Gr8NPoU2BIy2/gYrYSgAC9S9B3VXpwa/8lbpCEcWCVBslTnSXNEuw+V7ZzqPrhIhU2HmjSsV0dLQAWtoPXTU=
Message-ID: <58cb370e0511300305w635081e4iacf883fa3746f5d8@mail.gmail.com>
Date: Wed, 30 Nov 2005 12:05:08 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 10/11] blk: add FUA support to IDE
Cc: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051124162449.94344DD0@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051124162449.209CADD5@htj.dyndns.org>
	 <20051124162449.94344DD0@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/05, Tejun Heo <htejun@gmail.com> wrote:
> 10_blk_ide-add-fua-support.patch
>
>         Add FUA support to IDE.  IDE FUA support makes use of
>         ->protocol_changed callback to correctly adjust FUA setting
>         according to transfer protocol change.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK, except ->protocol_changed part
(IDE needs fixing if you want dynamic barrier changes, sorry)
