Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTESRZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTESRZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:25:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17845 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262390AbTESRZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:25:57 -0400
Date: Mon, 19 May 2003 10:39:08 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: And yet another it87 patch.
Message-ID: <20030519173908.GA25145@kroah.com>
References: <20030518222150.GA24805@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030518222150.GA24805@babylon.d2dc.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 06:21:50PM -0400, Zephaniah E. Hull wrote:
> Trivial, but important.
> 
> Somehow in the patching the bk tree somehow got two memset's to clear
> new_client in it87_detect, normally while this would be bad, it would
> not be critical.
> 
> However one of the two happens BEFORE the variable is set, and thus
> things go badly.

That's a wierd merge problem, sorry about that.

Applied.

greg k-h
