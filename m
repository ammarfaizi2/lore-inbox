Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135811AbRD2P1p>; Sun, 29 Apr 2001 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135814AbRD2P1f>; Sun, 29 Apr 2001 11:27:35 -0400
Received: from smtp2.fdn.com ([216.199.0.143]:52210 "EHLO smtp2.fdn.com")
	by vger.kernel.org with ESMTP id <S135811AbRD2P1Y>;
	Sun, 29 Apr 2001 11:27:24 -0400
Message-ID: <3AEC32D6.EC179FCB@fdn.com>
Date: Sun, 29 Apr 2001 11:27:18 -0400
From: Michael Pakovic <mpakovic@fdn.com>
Reply-To: mpakovic@fdn.com
X-Mailer: Mozilla 4.77 [en] (Win95; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.4 fork.c changes cause linuxconf to fail
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The changes to kernel/fork.c from 2.4.4-pre1 to 2.4.4-pre3 (and in
2.4.4) cause the RedHat 6.2 linuxconf utility to fail with the message
"broken pipe".  The linuxconf utility will run the first time, but all
subsequent runs give the "broken pipe" error.  The error message is
generated as a result of a fflush command in linuxconf.  I can provide
more information upon request.

Mike Pakovic

