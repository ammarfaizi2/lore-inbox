Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWEFWoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWEFWoX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 18:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWEFWoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 18:44:23 -0400
Received: from mx.freeshell.ORG ([192.94.73.18]:58606 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S932097AbWEFWoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 18:44:22 -0400
Date: Sat, 6 May 2006 22:43:57 +0000 (UTC)
From: Alexey Toptygin <alexeyt@freeshell.org>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, tony.luck@intel.com
Subject: Re: [PATCH] sendfile compat functions on x86_64 and ia64
In-Reply-To: <200605061046.24315.ak@suse.de>
Message-ID: <Pine.NEB.4.64.0605062241480.6792@norge.freeshell.org>
References: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org>
 <200605052328.21370.ak@suse.de> <Pine.NEB.4.62.0605052145140.25706@ukato.freeshell.org>
 <200605061046.24315.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 May 2006, Andi Kleen wrote:

>> I agree that this test will pass if we change the declaration of count to
>> u32 in sys32_sendfile,
>
> Again the compat layer is only supposed to be as good as a native 32bit
> kernel. You try to make it better by allowing values that a 32bit
> kernel wouldn't allow. But that's not its goal - it just wants to be
> as compatible as possible.

Absolutely not, this is not what I'm trying to do at all! My change will 
not make it accept values that the native 32 bit kernel won't accept - I 
had a very detailed description of why in my last mail.

> The goal isn't to be clear, the goal is to be compatible.
>
> Please stop continue arguing about this - it's useless.

Fine, you're the maintainer.

 			Alexey
