Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbSKNKWL>; Thu, 14 Nov 2002 05:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264825AbSKNKWL>; Thu, 14 Nov 2002 05:22:11 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:19724 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264822AbSKNKWK>; Thu, 14 Nov 2002 05:22:10 -0500
Date: Thu, 14 Nov 2002 11:28:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modules and the Interfaces who Love Them (Take I) 
In-Reply-To: <20021114032456.5676D2C0C9@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211141106200.2113-100000@serv>
References: <20021114032456.5676D2C0C9@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Nov 2002, Rusty Russell wrote:

> Look, your implementation was slow, confusing, invasive, inflexible
> *and* buggy.

My patch was meant as demonstration, you reduce it to a single aspect - 
the module - driver interface.
The patch was intended to demonstrate more. First of all, how to fix the 
module mess without breaking everything. It demonstrated a way to 
introduce a new interface without breaking compability. The new driver 
interface on top of it was optional, it could also have been the old 
interface or your monster refs.

> I seriously question your taste in this matter.  You obviously hold a
> personal dislike for my code.   Fine.

Doing to the linking in the kernel is just plain wrong. Most of the module 
code could perfectly live in user space and it could be as simple as your 
kernel loader.

> > maybe I'm missing something, but it doesn't fix anything
> 
> Then you don't understand the problem.

Maybe you could explain, what problems it fixes, that justifies complete 
breakage?

bye, Roman

