Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbWASPvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbWASPvV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161245AbWASPvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:51:21 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:64492 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1161239AbWASPvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:51:20 -0500
Date: Thu, 19 Jan 2006 10:51:22 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: "David S. Miller" <davem@davemloft.net>
cc: sfr@canb.auug.org.au, dwmw2@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch removed
 from -mm tree
In-Reply-To: <20060118.223629.100108404.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0601191048260.24315@excalibur.intercode>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
 <1137648119.30084.94.camel@localhost.localdomain> <20060119171708.7f856b42.sfr@canb.auug.org.au>
 <20060118.223629.100108404.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, David S. Miller wrote:

> I wish there were an exception for function prototypes and definitions.
> Why?  So grep actually works.
> 
> Hmmm, what args does function X take?  Let's try this:
> 
> bash$ git grep X
> 
> Oops, the args went past 80 columns and was split up, so I only
> get the first few in the grep output.

Linus already made this exception, some time ago on lkml, IIRC). I think 
it was 120 cols for functions.


- James
-- 
James Morris
<jmorris@namei.org>
