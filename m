Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRDYTcT>; Wed, 25 Apr 2001 15:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbRDYTcK>; Wed, 25 Apr 2001 15:32:10 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:62477 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131457AbRDYTb4>; Wed, 25 Apr 2001 15:31:56 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: a fork-like C-wrapper for clone(), DONE!
Date: 25 Apr 2001 12:31:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9c78mj$urn$1@cesium.transmeta.com>
In-Reply-To: <3AE6CD6B.745E@mat.upc.es> <9c77p7$upd$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9c77p7$upd$1@cesium.transmeta.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
> 
> glibc already contains such a wrapper; it is called __clone().  At
> least my system has "man clone" show the man page for it.
> 

Actually, the man page is wrong, it's called clone() unless you define
a function with that name yourself (weak symbol.)  My version of the
man pages are a bit old.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
