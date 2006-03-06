Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWCFNaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWCFNaj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWCFNai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:30:38 -0500
Received: from mailgate1.uni-kl.de ([131.246.120.5]:63635 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP
	id S1751190AbWCFNai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:30:38 -0500
Date: Mon, 6 Mar 2006 14:05:52 +0100
From: Eduard Bloch <edi@gmx.de>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Encrypting file system
Message-ID: <20060306130552.GA2121@debian>
References: <Pine.LNX.4.64.0603061600540.16555@vattikonda.junta.iitk.ac.in> <duh99h$i66$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <duh99h$i66$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Mario 'BitKoenig' Holbe [Mon, Mar 06 2006, 01:17:53PM]:
> V Bhanu Chandra <vbhanu.lkml@gmail.com> wrote:
> > I am thinking of designing and implementing a new native encrypting
> > file system for the linux kernel as a part of a student / research
> > project. Unlike dm-crypt/loop-AES/cryptoloop, I plan to target
> > slightly more ambitious user specifications such as: per-file random
> > secret encryption keys which are in-turn encrypted using the public
> > keys of all users having access to that filesystem object (a copy
> ...
> > Any comments / guidance / suggestions are most welcome and solicitated.
> 
> Since you are talking about an encrypting filesystems but only
> referencing encrypting block devices... Have you had a look at encfs
> and/or StegFS already?
> At least one of the encrypting block devices you mentioned (I don't
> remember which one) already has the ability to have multiple keys.

IIRC encfs does something like this (global key protected with pass
phrase and optional per-file IVs). And there is a new development:
http://ecryptfs.sourceforge.net/

Eduard.

-- 
Fast jede Frau ist schön, wenn sie Charme hat. Fast jede Frau hat
Charme, wenn sie Scham hat.
		-- Sigmund Graff
