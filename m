Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUDKQdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUDKQdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:33:04 -0400
Received: from waste.org ([209.173.204.2]:39117 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262391AbUDKQdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:33:02 -0400
Date: Sun, 11 Apr 2004 11:32:56 -0500
From: Matt Mackall <mpm@selenic.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: List of oversized inlines
Message-ID: <20040411163255.GB6248@waste.org>
References: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2004 at 07:05:49PM +0300, Denis Vlasenko wrote:
> Below you may find a list of inlines which have multiple callers
> and which compile to more than 39 bytes.

Could you perhaps subtract out the size of a null function and include
the product of size * uses?

> Tool used to obtain this list will be published when
> I will polish it a bit.

I'd obviously like to add this to the scripts in -tiny.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
