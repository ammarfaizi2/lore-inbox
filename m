Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbUDPMU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbUDPMU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:20:28 -0400
Received: from f03m-9-140.d1.club-internet.fr ([212.194.56.140]:3332 "EHLO
	FriBiGateway.pastresbeau.net") by vger.kernel.org with ESMTP
	id S262983AbUDPMUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:20:22 -0400
Message-ID: <407FCF89.6070305@free.fr>
Date: Fri, 16 Apr 2004 14:20:25 +0200
From: PasTresBeau <pastresbeau@free.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040410)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: nfs 2 over udp file corruption
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the following strange behavior:

Copying a file over a nfs v2-udp mount
gets the file corrupted.. the command
exits saying "mv: closing <my_filename>: IO Error"

The first copy after mounting the nfs volume succeed
but next all fails.

The problem disappear when copying over a nfs v3-tcp
mount.

This behavior appears with kernel 2.6.5,
but not with 2.6.4 and previous.

My kernel is the client, the server is running fbsd 4.9..

I am running 2.6.5 compiled with gcc 3.3 20040217
and binutils 2.14.90.0.8 on a P4 2.6 with HT, 512 RAM.

--
Damien
