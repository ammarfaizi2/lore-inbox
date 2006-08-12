Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWHLWu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWHLWu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 18:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWHLWu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 18:50:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:36107 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964890AbWHLWu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 18:50:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=h45NWuIJjkCxZHCqLqXplz6vqIAPbNvfm09aGg89L6uWwkmEx6nflgT/5hwMA5OMbLRJXmcPQTo2Q8eS45lARVvNjIpm8wx25N258g5kfr/wPT2yj9XSizX4xNfcKSaEv1Gu+XNjnidofJ+jGbIwM6MYMOD/oebrl5ffPBdNm8U=
Date: Sun, 13 Aug 2006 00:50:22 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: "Om N." <xhandle@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC : remote driver debugging efforts
Message-ID: <20060812225022.GB2509@slug>
References: <6de39a910608102319h76cfe171w1dab7aa700709dcf@mail.gmail.com> <4807377b0608121143k683653b6v47d257adef8a1cca@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0608121143k683653b6v47d257adef8a1cca@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 11:43:13AM -0700, Jesse Brandeburg wrote:
> On 8/10/06, Om N. <xhandle@gmail.com> wrote:
> >(I do not have a remote power on/off switch. The driver panics so
> >often that somebody has to babysit the machine to switch it off and
> >on. We are in different time zones and things are not moving forward at all)
> 
> add panic=30 to your kernel options in grub (or echo 30 >
> /proc/sys/kernel/panic) to reboot the system automatically on panic.
> 
On a similar note, kexec -p might help too.

Regards,
Frederik
