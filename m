Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbUJ2Tj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUJ2Tj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUJ2Tix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:38:53 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:37573 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S261979AbUJ2THC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:07:02 -0400
Message-ID: <418294CD.8000507@esoterica.pt>
Date: Fri, 29 Oct 2004 20:06:53 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041005
X-Accept-Language: pt, pt-br
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: K 2.6.9 - NFS: lstat causes "permission errors"
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting several "permission errors" when using
"lstat". So far I only found this on Directories.
I changed a program to retry the "lstat" whenever
a "permission error" occurs and it works successfully.

