Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272785AbRIMWxl>; Thu, 13 Sep 2001 18:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272782AbRIMWxa>; Thu, 13 Sep 2001 18:53:30 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:32697 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S272774AbRIMWxZ>; Thu, 13 Sep 2001 18:53:25 -0400
Message-ID: <003201c13ca6$f1aeffa0$020ba8c0@theflat.net>
From: "Simon Turvey" <turveysp@ntlworld.com>
To: <linux-kernel@vger.kernel.org>
Subject: Modifying file_operations
Date: Thu, 13 Sep 2001 23:53:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning! This might be a stupid question.

Is it safe to modify the read() entry of a driver's file_operations struct
in order to modify the behaviour of the driver depending upon some context,
say a particular hardware mode.  Or is the only way to do this safely to
test the current mode in read() adding overhead to the function.

Ta,
    Simon


