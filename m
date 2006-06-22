Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWFVSsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWFVSsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWFVSsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:48:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:8309 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932620AbWFVSsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:48:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=jcddGBLFKTlboDYsQoNThEvxCgt9hlGOH9I3GFiKSJN/PaIcwYFXtLp3nIm2L5uYOK9Gw+EecyUfUGYBY8HeYMYl9V+scxKgM3dnKT8g3XeDIqSMFz1n4M81FvBG+ihgtmM6zsFtKzci4hoo2YgMCLEvv+KjpYVwXjpnYx6THlk=
Message-ID: <449AE613.4040307@gmail.com>
Date: Thu, 22 Jun 2006 12:48:51 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [ patch -mm1 00/11 ] gpio-patchset-fixups: series
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Andrew,

heres that pile of tiny patches..

It seems that a lot of the externs you noted were fixed in subsequent 
patches.
The other fixups should work for your 'insertion sort'.
Sorry about these faux-pas, I'll do better next time.

They apply cleanly on mm1, and build fine.
Sadly, I cant boot -mm1 ATM  (some nfsroot prob I'll try to dig into RSN),
so I tested against 17, theyre fine there.

# series-fixups
diff.2-fix-static-numpins
diff.3-fix-enomem
diff.3-fix-goto-undos-scx200
diff.13-fix-request-region
diff.13-fix-include-linux-io
diff.13-fix-static-no-init
diff.13-fix-weird-comment
diff.16-fix-explicit-precedence
diff.19-fix-call-init-shadow
diff.19-fix-extern-decl
diff.19-fix-pc8736x-modinit-err-undos

