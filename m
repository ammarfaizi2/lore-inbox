Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135580AbREBPQa>; Wed, 2 May 2001 11:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135585AbREBPQU>; Wed, 2 May 2001 11:16:20 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:20499 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S135580AbREBPQN>; Wed, 2 May 2001 11:16:13 -0400
Date: Wed, 2 May 2001 11:17:22 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4-ac3 +IPX -SYSCTL compile fix
In-Reply-To: <Pine.LNX.4.33.0105021040120.921-100000@fonzie.nine.com>
Message-ID: <Pine.LNX.4.33.0105021115090.8687-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#error This file shouldn't be compiled without CONFIG_SYSCTL defined

Oops, sorry! Unterminated string constant in preprocessor. It should be

#error This file should not be compiled without CONFIG_SYSCTL defined

The patch at http://www.red-bean.com/~proski/linux/ipxsysctl.diff has been
updated.

-- 
Regards,
Pavel Roskin

