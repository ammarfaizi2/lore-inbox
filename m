Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSDUIvk>; Sun, 21 Apr 2002 04:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311523AbSDUIvj>; Sun, 21 Apr 2002 04:51:39 -0400
Received: from as14-4-3.jak.s.bonet.se ([217.215.163.33]:22952 "EHLO
	pescadero.ampr.org") by vger.kernel.org with ESMTP
	id <S311454AbSDUIvj>; Sun, 21 Apr 2002 04:51:39 -0400
Message-ID: <3CC27D95.6A9F252F@ufh.se>
Date: Sun, 21 Apr 2002 10:51:33 +0200
From: Peter Enderborg <pme@ufh.se>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kermel <linux-kernel@vger.kernel.org>
Subject: Strange kernel logging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing with nmap and tryed to do portscan on my 2.4.18 kernel
with iptables.
I use port -sS -p 1 to search all ports. And I have iptables to do
logging on all
rejected messags. The scan mod was "norlmal" and that sends messags in
bursts.
And when this burts was recived the machine was very slo and had
keyboard problems.
It was very low latency for the keyevents. It was funny to see what
happend when
key relase event was delayed. A lot of same chars... This is on a dual
PII and
I guess that it is some race condition with in the logging in iptables.
Is this
a known problem? Any one that have solution?

