Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279005AbRKMVCf>; Tue, 13 Nov 2001 16:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278986AbRKMVCZ>; Tue, 13 Nov 2001 16:02:25 -0500
Received: from pD903C65A.dip.t-dialin.net ([217.3.198.90]:10370 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S278968AbRKMVCO>; Tue, 13 Nov 2001 16:02:14 -0500
Date: Tue, 13 Nov 2001 22:01:39 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: linux readahead setting?
Message-ID: <20011113220139.B30354@no-maam.dyndns.org>
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net> <Pine.LNX.4.33L.0111131355030.20809-100000@duckman.distro.conectiva> <20011113181650.A30354@no-maam.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011113181650.A30354@no-maam.dyndns.org>
User-Agent: Mutt/1.3.23i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, for all the answers via pm, but I would like to explain a litte
bit more what I am looking for. I got this filesystem on lvm, and I want
my harddisk if there a several processes accessing the disk-image to go
to the position of process one, read 256k of data, go to the position of
process two, read 256k of data, go again to the position of the nex
process, read 256k of data and so one to minimize movement of the
harddisk-readhead.

And of course my problem is, that I want that only on this filesystem
(it is a reiserfs-filesystem) or logical volum. Not on the other
filesystems on this harddisk which contain normal data or swapspace
(this behaviour could cause a really ugly performance for swapspace)

The system is currently able to fully satisfy a 100 mbit
ethernetconnection, but I would like how I can get some extra
performance in such situations.
