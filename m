Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVB1AJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVB1AJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVB1AHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:07:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:2225 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261205AbVB0Xsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 18:48:54 -0500
X-Authenticated: #26200865
Message-ID: <42225CEE.1030104@gmx.net>
Date: Mon, 28 Feb 2005 00:51:10 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: updating mtime for char/block devices?
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is it intentional that
echo foo >/dev/hda1
doesn't update the mtime of the device node, but
echo foo >/dev/tty10
does update the mtime of the device node?

And no, mounting with the noatime flag doesn't help because the
mtime is updated. IIRC some time ago this behaviour was different,
but I could easily be mistaken.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
