Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUI1EqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUI1EqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 00:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUI1EqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 00:46:11 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:48763 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267521AbUI1EqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 00:46:08 -0400
Message-ID: <dc54396f040927214651393131@mail.gmail.com>
Date: Tue, 28 Sep 2004 06:46:07 +0200
From: Ed Schouten <edschouten@gmail.com>
Reply-To: Ed Schouten <edschouten@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] i386: Xbox support
In-Reply-To: <4158AA5B.8090601@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <65184.217.121.83.210.1096308147.squirrel@217.121.83.210>
	 <4158AA5B.8090601@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

On Tue, 28 Sep 2004 10:03:39 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Any real point to merging this? (I honestly don't know, I don't follow the
> xbox hacking scene).

Yes, it does (in my opinion). This small 7 KB patch allows you to run
a vanilla kernel on the machine (with exception of the video driver).

I also noticed my previous mailclient (Squirrelmail) did some
linebreaking. Please notice:

+ if ((bus == 0) && !PCI_SLOT(devfn) && ((PCI_FUNC(devfn) == 1) ||
(PCI_FUNC(devfn) == 2)))

should be one line ;-)

Yours sincerely,
-- 
 Ed Schouten <edschouten@gmail.com>
 Website: http://g-rave.nl/
