Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbSLSOtC>; Thu, 19 Dec 2002 09:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSLSOtC>; Thu, 19 Dec 2002 09:49:02 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:4943 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S265506AbSLSOtB>; Thu, 19 Dec 2002 09:49:01 -0500
Date: Thu, 19 Dec 2002 15:57:06 +0100 (CET)
From: bart@etpmod.phys.tue.nl
Reply-To: bart@etpmod.phys.tue.nl
Subject: Re: Intel P6 vs P7 system call performance
To: billyrose@billyrose.net
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Message-Id: <20021219145707.9DE7A51F54@gum12.etpnet.phys.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec, billyrose@billyrose.net wrote:
> long_call:
>         pushl $0xfffff000
>         ret
> 

A ret(urn) to an address that wasn't put on the stack by a call
severly confuses the branch prediction on many processors.


-- 
Bart Hartgers - TUE Eindhoven 
http://plasimo.phys.tue.nl/bart/contact.html
