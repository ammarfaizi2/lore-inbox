Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135225AbRD3N5h>; Mon, 30 Apr 2001 09:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135245AbRD3N52>; Mon, 30 Apr 2001 09:57:28 -0400
Received: from fep01.swip.net ([130.244.199.129]:17392 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP
	id <S135225AbRD3N5Q> convert rfc822-to-8bit; Mon, 30 Apr 2001 09:57:16 -0400
Message-ID: <000901c0d17d$75ab1f40$01000001@pompel>
From: "Ola Garstad" <olag@eunet.no>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Mounting same device many times/mountpoints. Is this legal?
Date: Mon, 30 Apr 2001 15:57:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running kernel 2.4.3 on RH 7.0

By mistake I mounted the same device two places. Is this legal???
On 2.2.x I got an error if I did this.
It guess thus could have destoryed the filesystem if had written to it.

bash-2.04# mount
[lines removed]
/dev/hdc8 on /mnt/1 type reiserfs (rw)
/dev/hdc8 on /var/log type reiserfs (rw)



