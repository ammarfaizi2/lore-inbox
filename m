Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWGHAMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWGHAMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWGHAMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:12:18 -0400
Received: from terminus.zytor.com ([192.83.249.54]:57033 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932429AbWGHAMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:12:17 -0400
Message-ID: <44AEF836.9030406@zytor.com>
Date: Fri, 07 Jul 2006 17:11:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: bmap question (probably stupid)
References: <200607072338.55379.rjw@sisk.pl>
In-Reply-To: <200607072338.55379.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> Hi,
> 
> I'd like to use something like bmap() from the user space.  I've found the
> BMAP_IOCTL, but it's marked as obsolete, so my question is what's the
> recommended way of doing this?
> 

The FIBMAP ioctl seems to be the current method of choice.

	-hpa

