Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTIPSlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 14:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbTIPSlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 14:41:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:65493 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261976AbTIPSlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 14:41:16 -0400
Date: Tue, 16 Sep 2003 11:40:54 -0700
From: Greg KH <greg@kroah.com>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make pdfdocs problem
Message-ID: <20030916184054.GH4114@kroah.com>
References: <20030915105729.GA8576@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030915105729.GA8576@net-ronin.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 03:57:29AM -0700, carbonated beverage wrote:
> Hi all,
> 
> 	The `make pdfdocs' target still fails for me on the
> `writing_usb_drivers' document.  There's one small bug in it, and one
> problem I haven't figured out yet.
> 
> 	There is a malformed <literal>blah<literal> sequence, where the
> closing tag is instead an opening tag.  Patch for that below.

Thanks, I've applied this patch, and fixed up a missing </para> tag in
that file too.

greg k-h
