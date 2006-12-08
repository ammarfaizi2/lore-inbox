Return-Path: <linux-kernel-owner+w=401wt.eu-S1761183AbWLHUf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761183AbWLHUf3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 15:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761187AbWLHUf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 15:35:29 -0500
Received: from gw.goop.org ([64.81.55.164]:35999 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761183AbWLHUf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 15:35:28 -0500
Message-ID: <4579CC7F.1040203@goop.org>
Date: Fri, 08 Dec 2006 12:35:11 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Arkadiusz Miskiewicz <arekm@maven.pl>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: What was in the x86 merge for .20
References: <200612080401.25746.ak@suse.de> <200612081304.23230.arekm@maven.pl>
In-Reply-To: <200612081304.23230.arekm@maven.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arkadiusz Miskiewicz wrote:
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o: In function `math_emulate':
> (.text+0x3809): undefined reference to `_proxy_pda'
>   

Hm, in theory nothing should ever generate a reference to _proxy_pda. 
What compiler are you using?

    J
