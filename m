Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264122AbTDWQdz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbTDWQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:33:54 -0400
Received: from almesberger.net ([63.105.73.239]:6661 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264122AbTDWQdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:33:35 -0400
Date: Wed, 23 Apr 2003 13:45:30 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Julien Oster <frodoid@frodoid.org>
Cc: Robert Love <rml@tech9.net>, Julien Oster <frodo@dereference.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel ring buffer accessible by users
Message-ID: <20030423134530.C3557@almesberger.net>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org> <1051031876.707.804.camel@localhost> <20030423125602.B1425@almesberger.net> <20030423160556.GA30306@frodo.midearth.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423160556.GA30306@frodo.midearth.frodoid.org>; from frodoid@frodoid.org on Wed, Apr 23, 2003 at 06:05:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Oster wrote:
> Of course one could say "then let's just stop writing out anything in
> the kernel buffer that COULD be sensitive", but I think this would
> actually castrate the meaning of such a buffer.

It's also bad security design to try to plug hundreds of potential
leaks, instead of the one common channel they share.

> And there's stillt he possibility to tweak the permissions for
> dmesg so that only a certain group (staff, operator, adm...) can execute
> it, but then setuid root.

Yes, but you'll get quite a few objections to adding yet another
suid root program :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
