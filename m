Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbUJ1IVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbUJ1IVh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbUJ1IVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:21:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37554 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262819AbUJ1IVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:21:09 -0400
Date: Thu, 28 Oct 2004 09:21:08 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
Message-ID: <20041028082108.GR24336@parcelfarce.linux.theplanet.co.uk>
References: <41809921.10200@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41809921.10200@lbsd.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 07:00:49AM +0000, Nigel Kukard wrote:
> I just got the below oops when i mounted a usb camera's SD-Card.
> 
> Could anyone share some light on the issue?

Try to dd the contents of device to a file and loop-mount it.  If oops
remains, we would have something easier to deal with...
