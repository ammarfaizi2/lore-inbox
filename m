Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272664AbTHRQqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272778AbTHRQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:46:13 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:23332 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id S272664AbTHRQqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:46:10 -0400
Date: Mon, 18 Aug 2003 18:35:22 +0200
From: =?iso-8859-1?Q?S=E9bastien?= Hinderer 
	<Sebastien.Hinderer@libertysurf.fr>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Impossible to read files from a CD-Rom
Message-ID: <20030818163520.GA413@galois>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I'm using a vanila linux-2.6.0-test3.
When I try to use a CD-Rom, the mount is successful, so are the calls to
ls.
However, as soon as I try to read a file, I get a lot of messages such as :

hdc: rw=0, want=505092, limit=31544
Buffer I/O error on device hdc, logical block 126272
attempt to access beyond end of device

The computer is a Dell Lattitude laptop.
On the same machine, I can use CDs properly with a 2.4.18 kernel.

Cheers,
Sébastien.
