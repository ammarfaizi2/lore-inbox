Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWE0M7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWE0M7L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 08:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWE0M7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 08:59:11 -0400
Received: from ns.dynamicweb.hu ([195.228.155.139]:1225 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1751502AbWE0M7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 08:59:10 -0400
Message-ID: <01b701c6818d$4bcd37b0$1800a8c0@dcccs>
From: =?iso-8859-2?Q?Haar_J=E1nos?= <djani22@netcenter.hu>
To: <linux-kernel@vger.kernel.org>
Subject: How to send a break?
Date: Sat, 27 May 2006 14:58:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I wish to know, how to send a "BREAK" to trigger the sysreq functions on the
serial line, using echo.

I mean like this:

#!/bin/bash
echo "?BREAK?" >/dev/ttyS0
sleep 2
echo "m" >/dev/ttyS0

Thanks,
Janos

