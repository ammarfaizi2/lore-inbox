Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbTCKXt7>; Tue, 11 Mar 2003 18:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbTCKXt7>; Tue, 11 Mar 2003 18:49:59 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:25239 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261679AbTCKXt6>; Tue, 11 Mar 2003 18:49:58 -0500
Date: Tue, 11 Mar 2003 15:49:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in tty_open
Message-ID: <45750000.1047426594@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting lots of these messages whilst running big SDET runs on
an 16-way machine ... anyone recognize them?
(64-bk3 + a few patches).

dev (pts(136,0)) tty->count(4) != #fd's(3) in release_dev
Warning: dev (pts(136,0)) tty->count(4) != #fd's(3) in tty_open
Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in tty_open
Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in release_dev
Warning: dev (pts(136,0)) tty->count(5) != #fd's(4) in tty_open
Warning: dev (pts(136,0)) tty->count(6) != #fd's(5) in tty_open
Warning: dev (pts(136,0)) tty->count(7) != #fd's(6) in tty_open
Warning: dev (pts(136,0)) tty->count(8) != #fd's(7) in tty_open
Warning: dev (pts(136,0)) tty->count(9) != #fd's(8) in tty_open
Warning: dev (pts(136,0)) tty->count(10) != #fd's(9) in tty_open
Warning: dev (pts(136,0)) tty->count(11) != #fd's(10) in tty_open
Warning: dev (pts(136,0)) tty->count(12) != #fd's(11) in tty_open
Warning: dev (pts(136,0)) tty->count(13) != #fd's(12) in tty_open
Warning: dev (pts(136,0)) tty->count(14) != #fd's(13) in tty_open
Warning: dev (pts(136,0)) tty->count(15) != #fd's(14) in tty_open
Warning: dev (pts(136,0)) tty->count(16) != #fd's(15) in tty_open
Warning: dev (pts(136,0)) tty->count(17) != #fd's(16) in tty_open
Warning: dev (pts(136,0)) tty->count(18) != #fd's(17) in tty_open
Warning: dev (pts(136,0)) tty->count(18) != #fd's(17) in release_dev
Warning: dev (pts(136,0)) tty->count(18) != #fd's(17) in tty_open
Warning: dev (pts(136,0)) tty->count(19) != #fd's(18) in tty_open
Warning: dev (pts(136,0)) tty->count(20) != #fd's(19) in tty_open
Warning: dev (pts(136,0)) tty->count(21) != #fd's(20) in tty_open
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in tty_open
Warning: dev (pts(136,0)) tty->count(23) != #fd's(22) in tty_open
Warning: dev (pts(136,0)) tty->count(23) != #fd's(22) in release_dev
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in release_dev
Warning: dev (pts(136,0)) tty->count(21) != #fd's(20) in release_dev
Warning: dev (pts(136,0)) tty->count(21) != #fd's(20) in tty_open
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in tty_open
Warning: dev (pts(136,0)) tty->count(23) != #fd's(22) in tty_open
Warning: dev (pts(136,0)) tty->count(23) != #fd's(22) in release_dev
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in release_dev
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in tty_open
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in release_dev
Warning: dev (pts(136,0)) tty->count(21) != #fd's(20) in release_dev
Warning: dev (pts(136,0)) tty->count(20) != #fd's(19) in release_dev
Warning: dev (pts(136,0)) tty->count(20) != #fd's(19) in tty_open
Warning: dev (pts(136,0)) tty->count(21) != #fd's(20) in tty_open
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in tty_open
Warning: dev (pts(136,0)) tty->count(22) != #fd's(21) in release_dev
Warning: dev (pts(136,0)) tty->count(21) != #fd's(20) in release_dev
Warning: dev (pts(136,0)) tty->count(20) != #fd's(19) in release_dev
Warning: dev (pts(136,0)) tty->count(19) != #fd's(18) in release_dev
Warning: dev (pts(136,0)) tty->count(18) != #fd's(17) in release_dev
Warning: dev (pts(136,0)) tty->count(17) != #fd's(16) in release_dev
Warning: dev (pts(136,0)) tty->count(16) != #fd's(15) in release_dev
Warning: dev (pts(136,0)) tty->count(15) != #fd's(14) in release_dev
Warning: dev (pts(136,0)) tty->count(14) != #fd's(13) in release_dev
Warning: dev (pts(136,0)) tty->count(13) != #fd's(12) in release_dev
Warning: dev (pts(136,0)) tty->count(12) != #fd's(11) in release_dev
Warning: dev (pts(136,0)) tty->count(12) != #fd's(11) in tty_open
Warning: dev (pts(136,0)) tty->count(12) != #fd's(11) in release_dev
Warning: dev (pts(136,0)) tty->count(11) != #fd's(3) in release_dev
Warning: dev (pts(136,0)) tty->count(10) != #fd's(3) in release_dev
Warning: dev (pts(136,0)) tty->count(9) != #fd's(3) in release_dev
Warning: dev (pts(136,0)) tty->count(9) != #fd's(4) in tty_open
Warning: dev (pts(136,0)) tty->count(9) != #fd's(4) in release_dev
Warning: dev (pts(136,0)) tty->count(9) != #fd's(5) in tty_open
Warning: dev (pts(136,0)) tty->count(10) != #fd's(6) in tty_open
Warning: dev (pts(136,0)) tty->count(11) != #fd's(7) in tty_open


