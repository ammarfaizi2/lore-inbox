Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbVJPSW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVJPSW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 14:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVJPSW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 14:22:59 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53692 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751340AbVJPSW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 14:22:58 -0400
From: Junio C Hamano <junkio@cox.net>
To: Ed Tomlinson <tomlins@cam.org>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GIT 0.99.8d
References: <7vachadnmy.fsf@assigned-by-dhcp.cox.net>
	<200510161024.37873.tomlins@cam.org>
Date: Sun, 16 Oct 2005 11:22:57 -0700
In-Reply-To: <200510161024.37873.tomlins@cam.org> (Ed Tomlinson's message of
	"Sun, 16 Oct 2005 10:24:37 -0400")
Message-ID: <7vll0txqwu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

(Obligatory "do not top post" request omitted)

> Debian users beware.  This version introduces a dependency - package: 
> libcurl3-gnutls-dev
> is now needed to build git.

Is this really true?  The one I uploaded was built on this
machine:

: siamese; dpkg -l libcurl\* | sed -ne 's/^ii  //p'
libcurl3          7.14.0-2       Multi-protocol file transfer library, now wi
libcurl3-dev      7.14.0-2       Development files and documentation for libc

Having said that, a tested patch to debian/control to adjust
Build-Depends is much appreciated.


