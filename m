Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVLGO0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVLGO0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLGO0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:26:47 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:34701 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751087AbVLGO0q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:26:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dhk/1YgypYurMLAfJCt3V4zo8XHzCkkdoL8SsD6OYhkdnwua0ISwB0CitcZKTlPySMV6mzbBg4x6a6gerdCoOFSqzjF/XzwAB7ifzisqaStfw9OgKjxQsK/o/DqTDphPBLWikOHPZVP4fJ1kAM9LsRPTIaquwIzASVPlFsln/ns=
Message-ID: <58cb370e0512070626w735004afgf8cde34b8549fbdc@mail.gmail.com>
Date: Wed, 7 Dec 2005 15:26:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 12/7/05, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:
> >
> > > Isn't ide-io.c:ide_{start,complete}_power_step() enough?

Why feeding device with ACPI taskfile(s) can't be added to
the existing suspend/resume state machine (ide_*_power_step)?

> > No.
>
> Why? :)
