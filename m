Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWG2Tbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWG2Tbw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbWG2Tbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:31:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:56816 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752070AbWG2Tbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:31:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=A7WiDmegqbX11EOiZ1CCIqtMfd8LQHtGWaIJZ2mzXQ0G11en1L2yOysapr3MmW8vIRnctbeSlenh/lA4vtO55tEIFq8rGL6f5GneKWJNP8Ry4D9BTG8oBLgQsNUfRYvWQISFH5YM3u0+E6j1n5iyKWlqtBNVsZinsyrnZnAQoqM=
Date: Sat, 29 Jul 2006 21:30:50 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via sata oops on init
Message-ID: <20060729193050.GA18342@leiferikson.dystopia.lan>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060728233950.GD3217@redhat.com> <20060729144528.GD28712@leiferikson.dystopia.lan> <20060729164115.GA16946@redhat.com> <20060729170402.GA20649@leiferikson.dystopia.lan> <20060729171044.GE16946@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060729171044.GE16946@redhat.com>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 29, 2006 at 01:10:44PM -0400, Dave Jones wrote:
> You have to. Look at the allocation again. It's in a loop.
> The first of which may have succeeded.  Your patch will introduce
> a memory leak.

Holy crap! Yeah, I see it. Thanks :)

Hannes
