Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWHAJDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWHAJDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWHAJDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:03:30 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:39428 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751450AbWHAJD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:03:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=fEFuoY5/yOSCFZS8nk/DpkUYVOT4gp8qa4LLuOnLEIRf/4ohfHesjkJ2kbSHH2SMUlqm8CsJ7R8X06rzkbFunamCtSUyPahbVmZukPXaDM95twpEdXqYYmqXytvnBWEbnnfiAYLoEGvUweDrS8QFQ4hhMeDuf79SdA7coMBJCTo=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Jiri Slaby'" <jirislaby@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "'Martin Schwidefsky'" <schwidefsky@de.ibm.com>
Subject: RE: do { } while (0) question
Date: Tue, 1 Aug 2006 02:03:25 -0700
Message-ID: <008e01c6b549$59e52f70$493d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <44CF1631.3020104@gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: Aca1SAyUzu+ypWloQiWpem8b0caxpQAANxFA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> #if KILLER == 1
> #define MACRO
> #else
> #define MACRO do { } while (0)
> #endif
> 
> {
> 	if (some_condition)
> 		MACRO
> 
> 	if_this_is_not_called_you_loose_your_data();
> }
> 
> How do you want to define KILLER, 0 or 1? I personally choose 0.

Really? Does it compile?

Hua

