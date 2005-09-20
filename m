Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVITP3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVITP3s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVITP3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:29:48 -0400
Received: from kanga.kvack.org ([66.96.29.28]:49576 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965039AbVITP3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:29:47 -0400
Date: Tue, 20 Sep 2005 11:28:50 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Peter Duellings <Peter.Duellings@wincor-nixdorf.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel error in system call accept() under kernel 2.6.8
Message-ID: <20050920152850.GI32751@kvack.org>
References: <43301BC4.9080305@wincor-nixdorf.com> <20050920150755.GH32751@kvack.org> <433028A3.9090503@wincor-nixdorf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433028A3.9090503@wincor-nixdorf.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 05:20:03PM +0200, Peter Duellings wrote:
> Hi Ben,
> 
> if Log.Log would modify errno the Log.Log debug output should
> not be affected since the value of errno - from my understanding -
> is copied on the stack *before* Log.Log is called.
> Or did I forget something?

errno does not reside on the stack.

		-ben
