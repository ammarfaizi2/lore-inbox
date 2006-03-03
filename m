Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751917AbWCCGFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbWCCGFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbWCCGFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:05:21 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:46440 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751917AbWCCGFU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:05:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MRXNCqgyGY17jpe9m9envvriTO2jOvHVCBAmutz/KtRITDxnXBG/GSCsA6r9KxxZrPtfYl5cwjXc6zjs8cWTS2W9Gqo7LqK1Hncx/JezU9Hhw0jUpTrtYiPCBIqnZs9k3WrVDBFz17Tpn0fmP3r5puEgOzLkESp7u1sG0aBK21k=
Message-ID: <105c793f0603022205j124a9d19qab33c34e9750d5c9@mail.gmail.com>
Date: Fri, 3 Mar 2006 01:05:19 -0500
From: "Andrew Haninger" <ahaning@gmail.com>
To: "tim tim" <tictactoe.tim@gmail.com>
Subject: Re: modutils
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <503e0f9d0603022155j2570314jffcdf84060e336f2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <503e0f9d0603022041q717ae7cdo8539ba8f508dd681@mail.gmail.com>
	 <105c793f0603022138u6dca326ewa3b5d476f4c4ef48@mail.gmail.com>
	 <503e0f9d0603022141l5dc9a88ds380dd9dd2ba22c41@mail.gmail.com>
	 <105c793f0603022145t55f25cedpd6c40efd703530f5@mail.gmail.com>
	 <503e0f9d0603022155j2570314jffcdf84060e336f2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/06, tim tim <tictactoe.tim@gmail.com> wrote:
> here i am trying to install 2.6.10 kernel on the system that was fully
> installed RedHat EL3 (2.4.21). we followed this procedure..
I suspect that you might need to install a copy of mod-init-tools, the
latest version of which is 3.2.2.

> to install a kernel .. is it necessary to have a fully installed
> system..
I'm not sure what you mean. At least one system will need a compiler
and other libraries necessary to build the kernel. However, you could
configure and build a kernel on one machine and then copy it and its
related modules to another machine that does not have a compiler and
install the kernel there. In that way, you wouldn't need a
fully-installed system in order to install a kernel.

> and whether the kernel 2.6.10 can be installed on Fedora Core
> 3..
After a few searches, I think FC3 comes with a modified 2.6.9, so
moving to 2.6.10 should be possible. If not, then FC4 is out and
probably comes with a kernel newer than 2.6.10.

Hope this helps.

-Andy
