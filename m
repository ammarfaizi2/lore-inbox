Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286454AbSABAw3>; Tue, 1 Jan 2002 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286456AbSABAwT>; Tue, 1 Jan 2002 19:52:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63237 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286454AbSABAwJ>; Tue, 1 Jan 2002 19:52:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Two hdds on one channel - why so slow?
Date: 1 Jan 2002 16:52:02 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a0tlji$e5m$1@cesium.transmeta.com>
In-Reply-To: <0GPA00BK988OBK@mtaout45-01.icomcast.net> <Pine.LNX.4.10.10201011521190.6558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10201011521190.6558-100000@master.linux-ide.org>
By author:    Andre Hedrick <andre@linux-ide.org>
In newsgroup: linux.dev.kernel
> 
> Well if hell freezes over and I die, the patches to make the driver
> handled clean low_level IO threading will never be accepted.  Because they
> model the state-diagrams of the physical layer of the hardware exactly in
> the transport layer, it is totally orthoginal to the darwinism of Linux.
> Design is a problem, it is not permitted in a darwin-evolution model.
> 

I was trying to figure out what certain peoples issue with this was,
and the answer I got back was concern about buggy hardware (both host
side and target side) breaking the documented model.  I am personally
in no position to evaluate the veracity of that claim; perhaps you
could comment on how to deal with broken hardware in your model.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
