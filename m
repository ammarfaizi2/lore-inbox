Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbTHZBxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 21:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTHZBxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 21:53:02 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:18395 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262167AbTHZBxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 21:53:00 -0400
Date: Mon, 25 Aug 2003 21:52:56 -0400
From: Tom Vier <tmv@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: cryptoapi doesn't build
Message-ID: <20030826015256.GA9317@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <200308251148.h7PBmU8B027700@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200308251148.h7PBmU8B027700@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.22:

In file included from api.c:21:
internal.h:19:28: asm/kmap_types.h: No such file or directory
In file included from api.c:21:
internal.h:24: error: return type is an incomplete type
internal.h: In function rypto_kmap_type':
internal.h:25: error: invalid use of undefined type num km_type'
internal.h:25: warning: eturn' with a value, in function returning void

iirc, 2.4.21 had the same problem.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
