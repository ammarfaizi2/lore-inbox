Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266061AbRF1RyP>; Thu, 28 Jun 2001 13:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266062AbRF1RyF>; Thu, 28 Jun 2001 13:54:05 -0400
Received: from [64.64.109.142] ([64.64.109.142]:46089 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S266061AbRF1Rx7>; Thu, 28 Jun 2001 13:53:59 -0400
Message-ID: <3B3B6F30.E88DF9F3@didntduck.org>
Date: Thu, 28 Jun 2001 13:53:52 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael J Clark <clarkmic@pobox.upenn.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: A system call in the kernel
In-Reply-To: <200106281714.f5SHEmJ14746@pobox.upenn.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael J Clark wrote:
> 
> Any ideas on hot to easily call an outside program from the kernel (like
> system(), exec()....)  Is this possible?  Thanks

Check exec_usermodehelper in kmod.c

--

				Brian Gerst
