Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWBPOZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWBPOZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWBPOZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:25:55 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:13292 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932391AbWBPOZy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:25:54 -0500
Date: Thu, 16 Feb 2006 15:25:56 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.15.4 login errors
Message-ID: <20060216142556.GC5939@stiffy.osknowledge.org>
References: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.61.0602160859380.4753@chaos.analogic.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc3-marc-gd89b8f40-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* linux-os (Dick Johnson) <linux-os@analogic.com> [2006-02-16 09:13:46 -0500]:

> 
> 
> After installing linux-2.6.15.4, attempts to log in a non-root
> account gives these errors.
> 
> Password:
> Last login: Thu Feb 16 08:53:20 on tty1
> Keymap 0: Permission denied
> Keymap 1: Permission denied
> Keymap 2: Permission denied
> LDSKBENT: Operation not permitted
> loadkeys: could not deallocate keymap 3
> 
> I have searched /etc/profile, /etc/bashrc, all the scripts in
> /etc/profile.d. I can't find where loadkeys is even executed!
> 
> This is a RH Fedora base. Anybody know how to turn this crap off?
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.15.4 on an i686 machine (5590.48 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> _
> 

vi .profile .bashrc .bash_profile in the user's ~/ ?

The executed binary should be 'loadkeys'. Try 'loadkeys -s' as a user and see
the output on the console. Should be your quite your error messages...

Marc
