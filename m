Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUC1LpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUC1LpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:45:06 -0500
Received: from [80.72.36.106] ([80.72.36.106]:51347 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261168AbUC1LpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:45:03 -0500
Date: Sun, 28 Mar 2004 13:44:58 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Steve Kieu <s_kieu@hotmail.com>
Cc: maxime@tralhalla.org, linux-kernel@vger.kernel.org
Subject: Re: vmware and kernel 2.6 high cpu usage
In-Reply-To: <Sea1-F108LM2ViWLEkY000116a9@hotmail.com>
Message-ID: <Pine.LNX.4.58.0403281341010.343@alpha.polcom.net>
References: <Sea1-F108LM2ViWLEkY000116a9@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Steve Kieu wrote:
> >can you try changing the value of HZ from 1000 to 100 like in a 2.4
> >kernel? I bet this is it. Thanks,
> 
> yes it is fixed. Thanks. I reduce to 100 ; and try to notice the difference 
> when running with 1000 for others apps, at first things seems to be a bit 
> better (in general)

But why is the problem? Why vmware uses it and how can it (from user-level
unix programmer point of view)?

And can we cheat the value of HZ to be 100 to some broken apps while generally
it is 1000? (I need 1000 for some reasons.)


thanks in advance

Grzegorz Kulewski
