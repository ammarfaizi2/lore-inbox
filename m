Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVAOBsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVAOBsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVAOBl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:41:26 -0500
Received: from [81.2.110.250] ([81.2.110.250]:43497 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262115AbVAOBif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:38:35 -0500
Subject: Re: vgacon fixes to help font restauration in X11
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Egbert Eich <eich@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16867.58009.828782.164427@xf14.fra.suse.de>
References: <16867.58009.828782.164427@xf14.fra.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105745463.9839.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:33:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 14:28, Egbert Eich wrote:
> I'm fully aware that in the long run we will need to look into a new 
> driver model for graphics where no two instances fight over who gets
> register access. However such a model won't be created nor will we get 
> the majority of the drivers ported over night.
> Therefore we need to find an interim solution for the most pressing 
> problems.

This doesn't appear to work as a solution because the functionality
changes won't be in all the existing kernel, and also because the kernel
font save has a couple of bugs reported against it with regards to
saving the right data that might need looking at anyway.

It seems it would be neccessary for X to have a way to know whether the
feature is present.

