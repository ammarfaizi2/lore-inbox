Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbTCHP7l>; Sat, 8 Mar 2003 10:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262059AbTCHP7l>; Sat, 8 Mar 2003 10:59:41 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:24624 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S262055AbTCHP7k>; Sat, 8 Mar 2003 10:59:40 -0500
Date: Sat, 8 Mar 2003 17:01:34 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: John Bradford <john@grabjohn.com>
cc: Ludootje <ludootje@linux.be>, <linux-kernel@vger.kernel.org>
Subject: Re: what's an OOPS
In-Reply-To: <200303081420.h28EKHan001241@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.30.0303081654050.2790-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Mar 2003, John Bradford wrote:

> The number of the oops, (I.E. whether it was the first, second, third,
> etc, starting with 0000).

Urban myth (at least on i386). The "Oops:" part can be decoded on i386 as,

 *      bit 0 == 0 means no page found, 1 means protection fault
 *      bit 1 == 0 means read, 1 means write
 *      bit 2 == 0 means kernel, 1 means user-mode

      Szaka

