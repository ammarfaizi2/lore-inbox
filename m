Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311937AbSCOFoc>; Fri, 15 Mar 2002 00:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311940AbSCOFoW>; Fri, 15 Mar 2002 00:44:22 -0500
Received: from angband.namesys.com ([212.16.7.85]:33156 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S311937AbSCOFoO>; Fri, 15 Mar 2002 00:44:14 -0500
Date: Fri, 15 Mar 2002 08:44:08 +0300
From: Oleg Drokin <green@namesys.com>
To: Alex Walker <alex@x3ja.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.6 and 2.5.7-pre1 - reiserfs?
Message-ID: <20020315084408.A5622@namesys.com>
In-Reply-To: <20020314162009.F9664@x3ja.co.uk> <20020314192916.A1929@namesys.com> <20020314170123.G9664@x3ja.co.uk> <20020314200337.A2186@namesys.com> <20020314174027.H9664@x3ja.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314174027.H9664@x3ja.co.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Mar 14, 2002 at 05:40:27PM +0000, Alex Walker wrote:
> EXT3-fs: Unrecognized mount option conv
> EXT2-fs: Unrecognized mount option conv
> found reiserfs format "3.5" with standard journal
> [Usual boot messages]

Hm.
How about typing this at LILO prompt:
LILO: <your_image> rw rootfstype=reiserfs rootflags=conv

This one should work.

Bye,
    Oleg
