Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVAaFwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVAaFwl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 00:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVAaFwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 00:52:41 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:15243 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261929AbVAaFwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 00:52:39 -0500
Subject: Re: recent 2.6.x USB HID input weirdness
From: Marcel Holtmann <marcel@holtmann.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20050130212739.060f8e6f.davem@davemloft.net>
References: <20050130212739.060f8e6f.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 06:52:34 +0100
Message-Id: <1107150754.7801.8.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

> On sparc64 I just started getting this in my kernel logs
> on 2.6.x-BK from hidinput_input_event:
> 
> warning: event field not found
> 
> I added some debugging:
> 
> hidinput_input_event: type[4] code [4] value[458759]
> hidinput_input_event: type[4] code [4] value[458761]
> 
> This is on a Sun Type-6 USB keyboard.  It does this for
> every key I press.  The keys work properly, just the
> warning is printed (which makes the console kind of hard
> to use :-)

take a look at this patch: http://lkml.org/lkml/2005/1/29/111

Regards

Marcel


