Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUBRHXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 02:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUBRHXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 02:23:41 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:49844 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S263448AbUBRHXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 02:23:40 -0500
Date: Wed, 18 Feb 2004 08:23:32 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040218072332.GG1146@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org> <20040217164651.GB23499@mail.shareable.org> <yw1xr7wtcz0n.fsf@ford.guide> <20040217205707.GF24311@mail.shareable.org> <Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402171402460.23115@sm1420.belits.com>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 02:06:21PM -0700, Alex Belits <abelits@phobos.illtel.denver.co.us> wrote:
>   UTF-8 terminals (and variable-encoding terminals) alreay exist,
> gnome-terminal is one of them. They are, of course, bloated pigs, but I

rxvt-unicode (mixed fonts, bad complex script), and mlterm (no mixed
fonts, very good complex script support), are not all bloated, have a
_much_ smaller memory footprint than xterm and are even faster on text
output and scrolling complex scripts than xterm (by a factor of two).

(Of course, gnome-terminal is bloated. loading it requires 45MB of main
memory here and then it's still 5-10 times slower than xterm).

That UTF-8/Unicode in any way means bloated (I know you did not directly
imply this) is a widely circulating but wrong idea nowadays.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
