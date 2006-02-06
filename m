Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWBFTvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWBFTvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWBFTvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:51:46 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:15512
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932333AbWBFTvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:51:45 -0500
Date: Mon, 6 Feb 2006 11:51:56 -0800
From: Greg KH <greg@kroah.com>
To: David Chow <davidchow@shaolinmicro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
Message-ID: <20060206195156.GA5704@kroah.com>
References: <43E71AD7.5070600@shaolinmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E71AD7.5070600@shaolinmicro.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 05:45:59PM +0800, David Chow wrote:
> Is there any work in Linux undergoing to separate Linux drivers and the 
> the main kernel, and manage drivers using a package management system 
> that only manages kernel drivers and modules? If this can be done, the 
> kernel maintenance can be simple, and will end-up with a more stable 
> (less frequent changed) kernel API for drivers, also make every 
> developers of drivers happy.

The separation of drivers from the core kernel has nothing to do with
the stability of the in-kernel api.  To think otherwise is foolish, and
does not show an understanding of the current kernel apis.  See the
archives for all of the times this has come up previously.

> Would like to see that happens .

Feel free to submit patches to do so, if it is something you want to do.
Otherwise, telling other people to do something will not achieve
anything.

good luck,

greg k-h
