Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUKXXwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUKXXwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbUKXXtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:49:41 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49101 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262932AbUKXXqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:46:21 -0500
Date: Wed, 24 Nov 2004 15:25:27 -0800
From: Greg KH <greg@kroah.com>
To: Simon Fowler <simon@himi.org>, linux-kernel@vger.kernel.org,
       rl@hellgate.ch
Subject: Re: [2.6 PATCH] visor: Don't count outstanding URBs twice
Message-ID: <20041124232527.GB4394@kroah.com>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123193604.GA12605@k3.hellgate.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 08:36:04PM +0100, Roger Luethi wrote:
> Guys, can you please CC me when discussing patches of mine? I don't read
> LKML religiously, and my procmail filters are pretty dumb. Thanks. So
> my previous patch fixed the oops, but the driver's still borked.
> 
> Incrementing the outstanding_urbs counter twice for the same URB can't
> be good. No wonder Simon didn't get far syncing his Palm.
> 
> Signed-off-by: Roger Luethi <rl@hellgate.ch>

Applied, thanks.

greg k-h
