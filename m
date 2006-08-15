Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbWHOAg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWHOAg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWHOAg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:36:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:25447 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932761AbWHOAgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:36:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o3EFQDjfYC8Stqk49Pzi4K6O9fX2ugH9JJ/4wukD26VLNVpT7muGZix9q8eW2f7z6BY+yYyiioEO3bwmntM+UcBAVTGuXqcy858nLbakDb7/8We/FxYiCfxGcBikvognk5kLgzNdjgXk8/mj/nl6KJY4c6M+roWLzsF9bnanBlo=
Message-ID: <625fc13d0608141736q50dea86dh94cdf4ef19fe56d9@mail.gmail.com>
Date: Mon, 14 Aug 2006 19:36:54 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 0/4] Use 64-bit inode numbers internally in the kernel
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org#
In-Reply-To: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, David Howells <dhowells@redhat.com> wrote:
>
> These patches make the kernel use 64-bit inode numbers internally, even on a
> 32-bit system.  They are required because some filesystems have intrinsic
> 64-bit inode numbers: NFS and XFS for example.  The 64-bit inode numbers are
> then propagated to userspace automatically where the arch supports it.

Out of curiosity, is there a performance hit for 32-bit systems?  Have
you done any minimal benchmarks to see?

josh
