Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTKQXnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTKQXnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:43:07 -0500
Received: from main.gmane.org ([80.91.224.249]:15761 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262127AbTKQXnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:43:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: problem with suspend to disk on linux2.6-t9
Date: Tue, 18 Nov 2003 00:43:03 +0100
Message-ID: <yw1xzneuk1dk.fsf@ford.guide>
References: <200311172327.24418.shoxx@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:E4M0eY4nrJMJXWYmEZ/TcFtoJiA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dodger <shoxx@web.de> writes:

> it is suspending real fine.
> but it is not resuming at all.
> i tried to boot up normally and with resume=/dev/hdb5 ( swap partition ) but 
> nothing happens...

Try disabling the drive write cache with "hdparm -W0 /dev/hdb" before
suspending.  It did the trick for me, as well as curing some other
obscure problems.

-- 
Måns Rullgård
mru@kth.se

