Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSJXD00>; Wed, 23 Oct 2002 23:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbSJXD00>; Wed, 23 Oct 2002 23:26:26 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:57095
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265305AbSJXD0Z>; Wed, 23 Oct 2002 23:26:25 -0400
Subject: Re: [PATCH] niceness magic numbers, 2.4.20-pre11
From: Robert Love <rml@tech9.net>
To: Kristis Makris <devcore@freeuk.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035429764.528.8.camel@mcmicro>
References: <Pine.LNX.4.33L2.0210222332480.15859-100000@dragon.pdx.osdl.net> 
	<1035360961.4033.0.camel@irongate.swansea.linux.org.uk> 
	<1035402772.3171.1550.camel@phantasy>  <1035429764.528.8.camel@mcmicro>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 23:32:46 -0400
Message-Id: <1035430367.730.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 23:22, Kristis Makris wrote:
excuse my inexperience; I don't understand why a 41 value range
> is defined instead, and faked as a 40. Is this merely for the
> convinience of ignoring 0 ? From the nice manpage:
> 
> "Range goes from -20 (highest priority) to 19 (lowest)."

It is exported to user-space.  Changing it will break things.

	Robert Love

