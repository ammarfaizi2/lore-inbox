Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbUJaSnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbUJaSnW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 13:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUJaSnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 13:43:22 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:35802 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261388AbUJaSnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 13:43:19 -0500
Date: Sun, 31 Oct 2004 19:43:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Raid1 DM vs MD
In-Reply-To: <Pine.LNX.4.61.0410311902300.1819@merlin.sk-tech.net>
Message-ID: <Pine.LNX.4.53.0410311941390.27224@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0410311902300.1819@merlin.sk-tech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I had one MD-Raid1 where a good copy of the mirror was overwritten by the
>bad (old) copy ... I lost 3 Month worth of data and I am expecting loosing
>a linux project and in the worst case - even a court case :(

Yep, happened to me too, and ever since, I refrain from using MD, but instead a
good (read: my own) backup solution. It's even a little cheaper since you do
not to spare a partition/harddisk of the same size you're mirroring, but can
simply put the .tar.bz2 (+.acl.bz2) onto another fs.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
