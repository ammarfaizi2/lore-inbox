Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131975AbRBOAx0>; Wed, 14 Feb 2001 19:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRBOAxQ>; Wed, 14 Feb 2001 19:53:16 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:26448 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131975AbRBOAxB>;
	Wed, 14 Feb 2001 19:53:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "J . A . Magallon" <jamagallon@able.es>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: modules_install target 
In-Reply-To: Your message of "Thu, 15 Feb 2001 01:38:46 BST."
             <20010215013846.A25812@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Feb 2001 11:52:36 +1100
Message-ID: <22635.982198356@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001 01:38:46 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>I have recently noticed that 'make modules_install' tries as a last step
>
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.1-ac13; fi
>
>I depends on 'make install' doing the right symlinks in /boot.
>Would not be better to do a:
>
>if [ -r System.map-2.4.1-ac13 ]; then /sbin/depmod -ae -F System.map-2.4.1-ac13 
> 2.4.1-ac13; fi

The System.map depmod uses is the one in the top level linux directory.
It has nothing to do with where the distribution will copy that
System.map to, nor does it depend on /boot.  Leave it alone.

