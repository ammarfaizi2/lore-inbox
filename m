Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTI1WkH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 18:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTI1WkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 18:40:07 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:709 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S262729AbTI1WkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 18:40:05 -0400
Message-ID: <2ff401c38611$5ef13d20$44ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5, gcc 3.3, aic7(censored)_core.c
Date: Mon, 29 Sep 2003 07:38:09 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.0-test5, the README still says "Make sure you have gcc 2.95.3
available."  It is telling the truth.

SuSE 8.2 includes gcc 3.3 20030226 (prerelease).  Up to the point of
aborting, it diagnoses a ton of "warning: comparison between signed and
unsigned", but nonetheless compiles many source files and continues.  But in
aic7(censored)_core.c, line 76, it diagnoses "warning: `num_chip_names'
defined but not used".  Even though this is also just a warning, obviously
it threatens disastrous consequences  :-s  (sarcasm).  make[3] quits with
Error 1 and make[2] and make[1] quit with Error 2.

(My previous tests of 2.6.0-test[1-5] used the version of gcc that was in
SuSE 8.1.)

