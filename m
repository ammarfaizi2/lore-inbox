Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbSKTXoF>; Wed, 20 Nov 2002 18:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSKTXnV>; Wed, 20 Nov 2002 18:43:21 -0500
Received: from fmr02.intel.com ([192.55.52.25]:14017 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264910AbSKTXmp>; Wed, 20 Nov 2002 18:42:45 -0500
Message-ID: <001701c290ef$8417f020$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: [Coding style question] XXX_register or register_XXX
Date: Wed, 20 Nov 2002 15:49:50 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an accepted standard on naming for registration functions?  If have
a foo
object that other things can register and unregister with, should the
function names be:

int register_foo(&something);
int unregister_foo(&something);

 - or -

int foo_register(&something);
int foo_unregister(&something);

    -rustyl

