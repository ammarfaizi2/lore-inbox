Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUIPWDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUIPWDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267893AbUIPWDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:03:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26824 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267831AbUIPWD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:03:28 -0400
Subject: Re: argv null terminated in main()?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aleksandar Milivojevic <amilivojevic@pbl.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <414A04F6.8040106@pbl.ca>
References: <414A04F6.8040106@pbl.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095368471.23579.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Sep 2004 22:01:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-16 at 22:26, Aleksandar Milivojevic wrote:
> I was looking for info on this question on web and in documentation, but 
> couldn't find it documented anywhere.
> 
> The question is, after call to execve() system call, and after new image 
> is loaded, is argv (as passed to main() function of new program) NULL 
> terminated or not in Linux?

Yes. execve is documented in SuS v3 which you can find on the web. See
also info glibc which does have a lot more information on other useful
extensions like saved argv0 copies.


Alan

