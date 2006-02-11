Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWBKVec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWBKVec (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWBKVec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:34:32 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:33041 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S964800AbWBKVeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:34:31 -0500
Date: Sat, 11 Feb 2006 16:33:59 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] Your way doing kernel/module development
Message-ID: <20060211213359.GD3088@mail>
Mail-Followup-To: Marc Koschewski <marc@osknowledge.org>,
	linux-kernel@vger.kernel.org
References: <20060211154206.GD5721@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211154206.GD5721@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/06 04:42:06PM +0100, Marc Koschewski wrote:
> I'd like to get some short but, however, fully descriptive statements about how
> you do your module development. I mean, what your way of doing coding,
> insmod-ing, rmmod-ing, ... And what about code, that cannot be <M>, just [*] or
> must-be-built-in.
> 
> Hm, actually there's nothing more to say. Except that I'm tired of rebooting. ;)
> I tried kexec() but somehow I dont have all IDE devices sometimes on 'kexec -e'.
> So this just not a solution for me... :)
> 
> Marc

Depending on what part of the kernel you're working on you could look
at using a VM to test in, as long as you don't need direct access to
a specific piece of hardware in your machine you should be able to use
qemu, UML, VMWare, etc to boot your new kernel.

Jim.
