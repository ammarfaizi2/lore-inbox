Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278151AbRJLV3e>; Fri, 12 Oct 2001 17:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278152AbRJLV30>; Fri, 12 Oct 2001 17:29:26 -0400
Received: from m3d.uib.es ([130.206.132.6]:43453 "EHLO m3d.uib.es")
	by vger.kernel.org with ESMTP id <S278151AbRJLV3Q>;
	Fri, 12 Oct 2001 17:29:16 -0400
Date: Fri, 12 Oct 2001 23:29:46 +0200 (MET)
From: Ricardo Galli <gallir@m3d.uib.es>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.12-ac1 dies (seems reiserfs)
Message-ID: <Pine.LNX.4.33.0110122323460.7693-100000@m3d.uib.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time linux has died when un-installing a debian package from a remote
ssh terminal, so it might be related to ReiserFS.

There is no logs, sysrq didn't work neither.

Several files are corrupted:

linux:/var/log# dpkg -i "kernel-source*"
dpkg: error processing kernel-source* (--install):
 cannot access archive: No such file or directory
Errors were encountered while processing:
 kernel-source*


(i tried to remove kernel-source-2.4.7 when the machine hung).

--ricardo




