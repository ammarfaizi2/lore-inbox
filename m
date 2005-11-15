Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVKOHpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVKOHpz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 02:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVKOHpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 02:45:55 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:58280 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751366AbVKOHpy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 02:45:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WCKZ9yOp+K8j/M19kMVJwekarSAlYpUI1YVVehJjMyPzEL+8gnhqgnZRfsTTx9ElGEzmE7ftz2vzUwmMMb2oGhhx2vNFs2TvFV//YiZutUdhQsRaxoMEWpTwAjRA9mF2XVeGIbzfoQsnCa01GpZApyyyct9VMuhHmgasXVSU50w=
Message-ID: <64c763540511142345g4ca0b184y28962dae494f22b4@mail.gmail.com>
Date: Tue, 15 Nov 2005 13:15:54 +0530
From: Block Device <blockdevice@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: A standard snapshot notification framework in Linux ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   does the linux kernel provide a mechanism whereby applications can
register themselves
to be notified when a snapshot is being taken of the volume they might
be writing to.

   If there is no such framework then how do backup applications
guarantee ( application level ) consistency. I have seen freeze_bdev
and friends which work for file systems and how the device mapper uses
them. But when it comes to application level consistency, a mechanism
is required to give the application a chance to flush &  quiesce its
writes so that the backup taken will be consistent for the application
also. Windows has the VSS ( Volume Shadow Service ) which provides an
elaborate framework for this. Is anyone working on something similar
for Linux and if not why is it not such a worthwhile idea ?

Regards
BD
