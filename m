Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313601AbSDHJlk>; Mon, 8 Apr 2002 05:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313599AbSDHJlj>; Mon, 8 Apr 2002 05:41:39 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:42510 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S313597AbSDHJlj>; Mon, 8 Apr 2002 05:41:39 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Extraversion in System.map?
Date: Mon, 8 Apr 2002 09:41:38 +0000 (UTC)
Organization: Cistron
Message-ID: <a8roki$v7t$1@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.44.0204081502180.548-100000@holly.crl.go.jp> <1018246521.1534.145.camel@phantasy>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1018258898 31997 195.64.65.67 (8 Apr 2002 09:41:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1018246521.1534.145.camel@phantasy>,
Robert Love  <rml@tech9.net> wrote:
>Do what everyone else does and name your System.map appropriately, i.e.
>System.map-2.5.8-pre2 and then on boot symlink System.map to
>System.map-`uname -r`.  Most (all?) distributions do this for you
>already.

Not even that is needed. Most if not all utilities that need a
system.map file check for System.map-`uname -r` _first_ and only
if that is not found fall back to plain System.map. So the symlink
is superfluous.

Mike.

