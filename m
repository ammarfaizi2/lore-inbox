Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUCVFa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 00:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUCVFa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 00:30:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5304 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261725AbUCVFa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 00:30:26 -0500
Date: Mon, 22 Mar 2004 05:30:25 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Matt Miller <mmiller@hick.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: mmap complement, fdmap
Message-ID: <20040322053025.GR31500@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0403212157110.31106@jethro.hick.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403212157110.31106@jethro.hick.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2004 at 10:43:07PM -0600, Matt Miller wrote:
> 	``flags'' can be one of O_RDONLY, O_WRONLY, or O_RDWR.
> 
> I have verified functionality on ia32 and sparc as these are the only
> architectures I currently have some type of access to.  To test, start the
> kernel configuration process and go under File systems/Pseudo filesystems
> and select this option:
> 
> 	[*] Virtual memory file descriptor mapping support
> 
> Please let me know about any and all suggestions/bugs/flames.  I tried to
> be as thorough as possible but do suspect that I've missed some things.
> I'm looking forward to hearing feedback.

*boggle*

a) what the hell for?
b) what happens if I pass such descriptor to another task?
c) what happens if I mmap that sucker on the source range of addresses?
d) same for loops made of more than one of those...
e) see (a)
