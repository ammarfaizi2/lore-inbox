Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSIAGXp>; Sun, 1 Sep 2002 02:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSIAGXp>; Sun, 1 Sep 2002 02:23:45 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:52450 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S315491AbSIAGXo>; Sun, 1 Sep 2002 02:23:44 -0400
Subject: 2.5.33 SCTP typo fix
From: Nicholas Miell <nmiell@attbi.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Aug 2002 23:28:06 -0700
Message-Id: <1030861688.21053.5.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.5-build/net/sctp/sm_make_chunk.c.~1~	Thu Aug 29 16:54:46 2002
+++ linux-2.5-build/net/sctp/sm_make_chunk.c	Sat Aug 31 23:24:23 2002
@@ -1595,7 +1595,7 @@
 
 	case SCTP_PARAM_STATE_COOKIE:
 		asoc->peer.cookie_len =
-			ntohs(param.p->length) =
+			ntohs(param.p->length) -
 			sizeof(sctp_paramhdr_t);
 		asoc->peer.cookie = param.cookie->body;
 		break;

