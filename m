Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUAWTII (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266606AbUAWTII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:08:08 -0500
Received: from prin.lo2.opole.pl ([213.77.100.98]:49678 "EHLO
	prin.lo2.opole.pl") by vger.kernel.org with ESMTP id S266603AbUAWTHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:07:36 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Userland headers available
Date: Fri, 23 Jan 2004 20:04:47 +0100
User-Agent: KMail/1.5
References: <200401231907.17802.mmazur@kernel.pl> <20040123184755.GA2138@nevyn.them.org>
In-Reply-To: <20040123184755.GA2138@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401232004.47826.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 of January 2004 19:47, Daniel Jacobowitz wrote:
> I've done precisely the same thing for Debian - if I find the time,
> I'll compare...

How much testing did you have?

> I would really like to come up with an approach to maintain this
> interface definition in the kernel source.  I'm still trying to think
> of a way to do it without breaking compatibility or kernel builds.

As I really would like that (less work for me :) I do not think this is 
possible. First thing - 2.4 compatibility in 2.6 kernel would seem weird to 
say at least. Second - I've ripped out kernel code where I could and used 
glibc includes instead - this is (a) The Right Thing (tm) and (b) practically 
undoable inside kernel or would require huge amounts of work, which is really 
better of left outside.

-- 
Ka¿dy cz³owiek, który naprawdê ¿yje, nie ma charakteru, nie mo¿e go mieæ.
Charakter jest zawsze martwy, otacza ciê zgni³a struktura przeniesiona z 
przesz³o¶ci. Je¿eli dzia³asz zgodnie z charakterem wtedy nie dzia³asz w ogóle
- jedynie mechanicznie reagujesz.                 { Osho }
