Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUBGAzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUBGAzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:55:45 -0500
Received: from almesberger.net ([63.105.73.238]:39692 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265619AbUBGAzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:55:43 -0500
Date: Fri, 6 Feb 2004 21:55:38 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206215538.F18820@almesberger.net>
References: <20040206041223.A18820@almesberger.net> <20040206183746.GR4902@ca-server1.us.oracle.com> <20040206170917.E18820@almesberger.net> <200402062056.i16KuVS6020404@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402062056.i16KuVS6020404@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Feb 06, 2004 at 03:56:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> Well... it's the sort of problem that's very Schrodenger unless you have
> another thread/process observing.

In a way :-) What I meant was that the section on read() is worded
carefully to avoid making such assurances, but then we find such a
broad statement at the end of a section discussing specifically
threads (and not even concurrency in general, and after pointing
out that threads are optional).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
