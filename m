Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290686AbSARQTS>; Fri, 18 Jan 2002 11:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290730AbSARQTJ>; Fri, 18 Jan 2002 11:19:09 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62988 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290686AbSARQSy>; Fri, 18 Jan 2002 11:18:54 -0500
Date: Fri, 18 Jan 2002 17:18:49 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 fs corruption with 2.4.17
Message-ID: <20020118161849.GA17543@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020118143214.GH28471@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20020118143214.GH28471@westend.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Christian Hammers wrote:

> Again problems with my filesystems (probably a mainboard/cpu problem). 
> It is (^H^H^H was) a quite new ext3 fs that was created with 2.4.17 and the
> very latest (stable) e2fsprogs and journalling. The device 8,7 was /var so 
> the most used partition for write activity, read activity was mainly under
> /usr/local).  

Are you sure it's not your memory? Run memtest86; I recently had a box
screw up its filesystems because the DIMM went bad.

> > Jan 17 19:01:16 HOSTNAME kernel: EXT3-fs error (device sd(8,7)): ext3_new_block: Allocating block in system zone - block = 5931019
> [repeats several hundert times with increasing block numbers]

And that's what I got.

