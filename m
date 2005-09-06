Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVIFKdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVIFKdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 06:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVIFKdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 06:33:47 -0400
Received: from siaag1ag.compuserve.com ([149.174.40.13]:6124 "EHLO
	siaag1ag.compuserve.com") by vger.kernel.org with ESMTP
	id S964796AbVIFKdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 06:33:46 -0400
Date: Tue, 6 Sep 2005 06:29:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: RFC: i386: kill !4KSTACKS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ed Tomlinson <tomlins@cam.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509060631_MC3-1-A94D-9179@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1125845351.23858.25.camel@localhost.localdomain>

On Sun, 04 Sep 2005 at 15:49:11 +0100, Alan Cox wrote:

> The question is whether ndiswrapper can do stack switching itself. Since
> as I understand it the NT stack is way more than 8K.

  W2K usable kernel stack is about two pages.  I'm not clear whether
this is really:

        a) three pages with huge amount of fixed info, or
        b) two pages with tiny info like Linux
__
Chuck
