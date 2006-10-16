Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWJPGnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWJPGnm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWJPGnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:43:42 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:53657 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1751467AbWJPGnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:43:42 -0400
Date: Sun, 15 Oct 2006 23:43:41 -0700 (PDT)
From: dean gaudet <dean@arctic.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: Neil Brown <neilb@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
In-Reply-To: <20061016064039.GB3090@apps.cwi.nl>
Message-ID: <Pine.LNX.4.64.0610152342400.10294@twinlark.arctic.org>
References: <17710.54489.486265.487078@cse.unsw.edu.au>
 <1160752047.25218.50.camel@localhost.localdomain> <17714.52626.667835.228747@cse.unsw.edu.au>
 <20061016064039.GB3090@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Andries Brouwer wrote:

> A funny effect might be that hda5 exists, hda6 does not, and hda7 exists again.
> Maybe unexpected for some software.

why would that be unexpected?  that seems entirely normal these days with 
udev...

# ls /dev/hda?
/dev/hda1  /dev/hda2  /dev/hda5

-dean
