Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbTLVNbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 08:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTLVNbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 08:31:06 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:35339 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264871AbTLVNbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 08:31:05 -0500
Date: Mon, 22 Dec 2003 14:15:05 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Niraj Kumar <niraj17@iitbombay.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to read partition table
Message-ID: <20031222131505.GA14766@win.tue.nl>
References: <3FE6AE25.507@iitbombay.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE6AE25.507@iitbombay.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 02:11:09PM +0530, Niraj Kumar wrote:

> Is there an ioctl command (or sys call) in the latest 2.6 kernel to read 
> the complete partition table
> from user space?

The syscall is called read().

If you want to see it done, look at partx in util-linux.

