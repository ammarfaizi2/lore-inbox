Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbTIYVvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTIYVuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:50:35 -0400
Received: from mail.kroah.org ([65.200.24.183]:23452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261901AbTIYVuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:50:20 -0400
Date: Thu, 25 Sep 2003 14:01:04 -0700
From: Greg KH <greg@kroah.com>
To: Philippe Troin <phil@fifi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in vanilla 2.4.22 serial-usb driver
Message-ID: <20030925210104.GB29680@kroah.com>
References: <87llsdy01v.fsf@ceramic.fifi.org> <20030925185039.GB29088@kroah.com> <87eky4hauq.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eky4hauq.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 01:27:57PM -0700, Philippe Troin wrote:
> > > BTW, is there any way to restart khubd without rebooting?
> > 
> > Nope, sorry.
> 
> Are there any technical reasons behind that, or that just that it is
> not implemented?

It's a bit hard to restart a kernel thread that is oopsed :)

greg k-h
