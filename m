Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbRBOPPS>; Thu, 15 Feb 2001 10:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129072AbRBOPPI>; Thu, 15 Feb 2001 10:15:08 -0500
Received: from kamov.deltanet.ro ([193.226.175.59]:33546 "HELO
	kamov.deltanet.ro") by vger.kernel.org with SMTP id <S129071AbRBOPO4>;
	Thu, 15 Feb 2001 10:14:56 -0500
Date: Thu, 15 Feb 2001 17:14:45 +0200
From: Petru Paler <ppetru@ppetru.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1: TCP assertion failed
Message-ID: <20010215171445.A2327@ppetru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moderately-high (couple hundred thousand hits a day) loaded web server 
running 2.4.1 (no other patches). I got this twice in the syslog after
15 days uptime:

KERNEL: assertion (tp->lost_out == 0) failed at tcp_input.c(1202):tcp_remove_reno_sacks

(between lots of "TCP: peer xxxx shrinks window xxxx:xxx:xxxxxx. Bad, what else
can I say?" which I understand are harmless)

Let me know if anyone needs more info/tests/etc.

--
Petru Paler, mailto:ppetru@ppetru.net
http://www.ppetru.net - ICQ: 41817235
