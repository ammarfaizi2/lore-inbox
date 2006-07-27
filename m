Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWG0ReQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWG0ReQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWG0ReQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:34:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49828 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750929AbWG0ReO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:34:14 -0400
Message-ID: <44C8F8F3.2090606@zytor.com>
Date: Thu, 27 Jul 2006 10:33:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@gmail.com>
CC: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI> <a36005b50607271013o3c03238fq4ecea87dcd3c1e90@mail.gmail.com>
In-Reply-To: <a36005b50607271013o3c03238fq4ecea87dcd3c1e90@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> On 7/27/06, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
>> Sure. Though I wonder if sys_frevoke is enough for us and we can drop
>> sys_revoke completely.
> 
> No, you want sys_revoke/sys_revokeat.  Simplest case: /dev/rst0 vs
> /dev/nrst0.  You don't want the open rewind the drive.

No need to add sys_revoke.

	-hpa
