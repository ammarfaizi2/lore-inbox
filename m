Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWDMIsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWDMIsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWDMIsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 04:48:11 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:8337 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751158AbWDMIsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 04:48:10 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Avramenko Andrew <liksx@mail.ru>
Subject: Re: Troubles with booting init
Date: Thu, 13 Apr 2006 11:47:05 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <443E0DEC.4000602@mail.ru>
In-Reply-To: <443E0DEC.4000602@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131147.05686.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 11:38, Avramenko Andrew wrote:
> Hello!
> 
> 
> I have a computer with motherboard VIA EPIA-V.
> (http://www.via.com.tw/en/products/mainboards/mini_itx/epia_v/)
> 
> I've compiled kernel for it but it doesn't work. It doesn't shows any 
> error but stopped with:
> 
> 
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 136k freed.
> Executing init=/sbin/init
> 
> 
> Then there are no any other messages. Computer is alive (keyboard input 
> is worked).
> 
> 
> Please help me.

I bet your /sbin/init (or all programs spawned by it)
is compiled with P4 instructions (cmov or something like that).

Recompile those for 386.
--
vda
