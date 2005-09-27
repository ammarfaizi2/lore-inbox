Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVI0CbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVI0CbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 22:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVI0CbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 22:31:00 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:62645 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964798AbVI0Ca7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 22:30:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JrJs2q5qOJ+Qu/YxOnHqqohuUqXik4R/NTAEEpm6E1vPpNIFQoIpv6I5d3Frypwj+CzwHMsGnoVxCa7eB5lSBiKBYUAbSr79c+YyaNVfzdH+OC+TQDYPc1XEITYn8ukv/PLwDvVi/20lgojDMJSOX+lKPYzTxqxe7yc+TyPeZHw=
Message-ID: <355e5e5e05092619306a01d0f7@mail.gmail.com>
Date: Mon, 26 Sep 2005 22:30:56 -0400
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/3] Add disk hotswap support to libata RESEND #5
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <355e5e5e0509261800271c39b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <355e5e5e0509261800271c39b7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/05, Lukasz Kosewski <lkosewsk@gmail.com> wrote:
> The remaining vestiges of issues that I see might be related to
> swapping strange combinations of disks... I"ve tried to properly reset
> flags and such to allow swapping and switching arbitrary disks, but I
> only have a few disks and so only observed a few errors.  If you get
> strange errors trying to go from some disk of type A to another disk
> of type B (for instance, LBA48 to non-LBA48 drives, vice versa,
> different capacities being picked up wrong, etc), let me know!

I should point out that this paragraph doesn't imply what it looks
like it's implying because I wrote it poorly.

I have fixed all the disk issues I have observed.  I hypothesize that
there are other ones which I don't know about.  That's what the
paragraph SHOULD say.

Luke Kosewski
