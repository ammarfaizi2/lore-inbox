Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUCPVmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUCPVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:42:21 -0500
Received: from pop.gmx.net ([213.165.64.20]:12184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261719AbUCPVmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:42:20 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Valdis.Kletnieks@vt.edu
Subject: Re: NVIDIA and 2.6.4?
Date: Tue, 16 Mar 2004 22:55:51 +0100
User-Agent: KMail/1.6.1
References: <405082A2.5040304@blueyonder.co.uk> <200403162149.41018.dominik.karall@gmx.net> <200403162119.i2GLJ9uY014711@turing-police.cc.vt.edu>
In-Reply-To: <200403162119.i2GLJ9uY014711@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403162255.52087.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 22:19, you wrote:
> On Tue, 16 Mar 2004 21:49:40 +0100, Dominik Karall <dominik.karall@gmx.net>  
said:
> > can you let me know how to compile the nvidia drivers for 4KSTACK? cause
> > in the 2.6.5-rc1-mm1 is no more option to deactivate 4KSTACK.
>
> Get the 2.6.5-rc1-mm1-broken-out.tar.bz2, untar it, then
>
> patch -p1 -R < broken-out/4k-stacks-always-on.patch
>
> Yes, the *right* thing would be for NVidia to fix the binary.  However,
> this is a lot more expedient than waiting. :)

thx, works now with 8k stack size :)

greets
