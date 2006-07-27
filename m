Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWG0RPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWG0RPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWG0RPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:15:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38302 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750957AbWG0RPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:15:21 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org, viro@zeniv.linux.org.uk,
       tytso@mit.edu, tigran@veritas.com
In-Reply-To: <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <a36005b50607270941n187e8b06ga9b1b6454cf2e548@mail.gmail.com>
	 <Pine.LNX.4.58.0607272004270.7152@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jul 2006 18:33:36 +0100
Message-Id: <1154021616.13509.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-27 am 20:05 +0300, ysgrifennodd Pekka J Enberg:
> Sure. Though I wonder if sys_frevoke is enough for us and we can drop 
> sys_revoke completely.

Alas not. Some Unix devices have side effects when you open() them. 

