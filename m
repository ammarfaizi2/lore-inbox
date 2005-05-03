Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVECQop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVECQop (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVECQop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:44:45 -0400
Received: from alog0542.analogic.com ([208.224.223.79]:27621 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261317AbVECQon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:44:43 -0400
Date: Tue, 3 May 2005 12:44:38 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8: cannot specify -o with -c or -S and multiple compilations
In-Reply-To: <42779F6A.2000200@ammasso.com>
Message-ID: <Pine.LNX.4.61.0505031240580.4005@chaos.analogic.com>
References: <42779F6A.2000200@ammasso.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2005, Timur Tabi wrote:

> I just compiled and booted 2.6.11.8 over a Suse 9.2 system (2.6.8-24), and when I try to
> compile an external module, I get this error:
>
> gcc: cannot specify -o with -c or -S and multiple compilations
>

I've see this when something is on the command-line that you
didn't expect, like including a search-path without -I or a
definition without -D or something like that. Check to see what
your Makefile definitions actually resolve to.

[SNIPPED...]


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
