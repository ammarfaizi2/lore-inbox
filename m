Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268654AbTCCTlD>; Mon, 3 Mar 2003 14:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268657AbTCCTlC>; Mon, 3 Mar 2003 14:41:02 -0500
Received: from cub.phpwebhosting.com ([66.33.48.250]:33809 "HELO
	cub.phpwebhosting.com") by vger.kernel.org with SMTP
	id <S268654AbTCCTlA> convert rfc822-to-8bit; Mon, 3 Mar 2003 14:41:00 -0500
From: "Jared Daniel J. Smith" <linux@trios.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.6 (1006) - Licensed Version
Date: Mon, 3 Mar 2003 13:46:34 -0800
Subject: RE: [PATCH] 2.5.63-current Yet more spelling fixes from spell-fix.pl
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <20030303194100Z268654-29901+7275@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

The following diff corrects address=addresss
when it should correct addresses=addresss

IOW, the script singularized a plural typo.

-Jared

>diff -ur 2.5-current/include/net/sctp/user.h linux/include/net/sctp/user.h
>--- 2.5-current/include/net/sctp/user.h        Mon Mar  3 10:41:43 2003
>+++ linux/include/net/sctp/user.h        Mon Mar  3 10:45:23 2003
>@@ -100,13 +100,13 @@
>#define SCTP_SOCKOPT_BINDX_REM        SCTP_SOCKOPT_BINDX_REM
>SCTP_SOCKOPT_PEELOFF,         /* peel off association. */
>#define SCTP_SOCKOPT_PEELOFF        SCTP_SOCKOPT_PEELOFF
>-        SCTP_GET_PEER_ADDRS_NUM,         /* Get number of peer addresss. */
>+        SCTP_GET_PEER_ADDRS_NUM,         /* Get number of peer address. */
>#define SCTP_GET_PEER_ADDRS_NUM        SCTP_GET_PEER_ADDRS_NUM
>-        SCTP_GET_PEER_ADDRS,         /* Get all peer addresss. */
>+        SCTP_GET_PEER_ADDRS,         /* Get all peer address. */
>#define SCTP_GET_PEER_ADDRS        SCTP_GET_PEER_ADDRS
>-        SCTP_GET_LOCAL_ADDRS_NUM,         /* Get number of local addresss. */
>+        SCTP_GET_LOCAL_ADDRS_NUM,         /* Get number of local address. */
>#define SCTP_GET_LOCAL_ADDRS_NUM        SCTP_GET_LOCAL_ADDRS_NUM
>-        SCTP_GET_LOCAL_ADDRS,         /* Get all local addresss. */
>+        SCTP_GET_LOCAL_ADDRS,         /* Get all local address. */
>#define SCTP_GET_LOCAL_ADDRS        SCTP_GET_LOCAL_ADDRS
>};
>



