Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVJGMIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVJGMIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJGMIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:08:40 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:57623 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932397AbVJGMIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:08:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole;
        b=sieWF/HNkE41sBInEnjsWj6fEsqGOpr6oibzThkkGlyBXVcw6wBxf/R4rJ9+6QPp+JJCO6SEvfhzb58APeW+Q6A33RzTG+pCeLVqxtkOk/hWiOam/gIwQbWuOIbCFL+QzcWPyAXUuctPzSSXe4mTBkhggEiIfpZjCLp80k/iumM=
Message-ID: <007701c5cb37$da03d050$c901a8c0@sp>
From: <sampersy@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: What does that "%U0" and "%X0" mean
Date: Fri, 7 Oct 2005 20:08:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What does that "%U0" and "%X0" mean in 
__asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));

does any reference existing ?
