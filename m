Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVL0Dcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVL0Dcn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 22:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVL0Dcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 22:32:42 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:23263 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932205AbVL0Dcm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 22:32:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s/bB7/DW1dzEK7UBJpK56oMOExP3NTverwhOYvdrf9DdTju4Qc86/GJmWq3PjT9aUx+l3Ir+fBxhK4sGsQe7asF7MbyiJS+Wo/luf/IoWCO9V9XUGF9qGpF2bDAewOp4Q7jZd8WPTrL/InTUyWSskbib2ylOtCuLXeBt77HSH+I=
Message-ID: <7cd5d4b40512261932v12149210u52cf97c4bc203871@mail.gmail.com>
Date: Tue, 27 Dec 2005 11:32:41 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: do we still need the jiffies wraparound functions ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Under the kernel 2.6.x,the jiffies is defined as u64.We cannot count
on it to overflow.
Do we still need the functions to solve this problem?

Thank you.
