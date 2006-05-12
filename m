Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWELTFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWELTFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 15:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWELTFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 15:05:04 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51842 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751340AbWELTFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 15:05:01 -0400
Date: Fri, 12 May 2006 12:08:19 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: "sej.kernel" <sej.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mlock into kernel module
Message-ID: <20060512190819.GD2697@moss.sous-sol.org>
References: <4464A819.2050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4464A819.2050706@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* sej.kernel (sej.kernel@gmail.com) wrote:
> I need to use mlock and munlock function into a kernel module. How so
> I call this system call from my module ?

You shouldn't.

> I need to do this because I must use mlock in my software, but I can't
> use root or suser to start it. So mlock alwaays fail.

You should be using rlimits for this.

thanks,
-chris
