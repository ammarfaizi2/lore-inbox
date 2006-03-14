Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWCNNL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWCNNL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCNNLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:11:55 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51125 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1752113AbWCNNLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 08:11:54 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Aurelien Degremont <aurelien.degremont@cea.fr>
Subject: Re: /dev/stderr gets unlinked 8]
Date: Tue, 14 Mar 2006 15:11:27 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200603141213.00077.vda@ilport.com.ua> <200603141308.OAA25709@styx.bruyeres.cea.fr>
In-Reply-To: <200603141308.OAA25709@styx.bruyeres.cea.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141511.27965.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 15:07, Aurelien Degremont wrote:
> > Can I make /dev/stderr non-unlink-able?
> 
> Take a look to
> 
> $ man chattr
> # chattr +i /dev/stderr
> 
> if you are using a ext2/3 filesystem. If not, maybe your filesystem has 
> some similar functionality.

I have ramfs based /dev, which I mount early over /dev (from initrd, in fact).
On-disk /dev/ is empty.
--
vda
