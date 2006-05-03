Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWECNFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWECNFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWECNFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:05:17 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:34284 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030188AbWECNFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:05:16 -0400
Date: Wed, 3 May 2006 15:05:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jared Hulbert <jaredeh@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Advanced XIP File System
Message-ID: <20060503130502.GD19537@wohnheim.fh-wedel.de>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006 14:53:06 -0700, Jared Hulbert wrote:
> 
> I will be submitting a new filesystem for inclusion into the kernel as
> soon as it is ready.  (It mounts but doesn't like doing much else
> right now.)  I would like to get feedback now to mold the development
> as we go along.  Please comment on the technical approaches and other
> inherent qualities or lack thereof.

o Document the on-medium format
o Lindent
o Remove whitespace damage
o Consider saving a zlib workspace by moving it out of your code and
  sharing the infrastructure with cramfs and jffs2

Jörn

-- 
"[One] doesn't need to know [...] how to cause a headache in order
to take an aspirin."
-- Scott Culp, Manager of the Microsoft Security Response Center, 2001
