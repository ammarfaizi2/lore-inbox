Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965885AbWKNOex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965885AbWKNOex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 09:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965887AbWKNOex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 09:34:53 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:14829 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S965886AbWKNOew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 09:34:52 -0500
Date: Tue, 14 Nov 2006 10:32:18 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Emmanuel Fleury <fleury@labri.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [UML] arch/um/os-Linux/skas/process.c:328: error: 'PAGE_SHIFT' undeclared
Message-ID: <20061114153218.GA3988@ccure.user-mode-linux.org>
References: <4559A0D7.6050808@labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4559A0D7.6050808@labri.fr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 11:56:23AM +0100, Emmanuel Fleury wrote:
> arch/um/os-Linux/skas/process.c: In function 'copy_context_skas0':
> arch/um/os-Linux/skas/process.c:328: error: 'PAGE_SHIFT' undeclared
> (first use in this function)

> Solved with the following patch (probably already solved but just in
> case you didn't...):

Yup, I added that to my tree last night.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
