Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVCNNRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVCNNRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 08:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVCNNRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 08:17:48 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:61013 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261473AbVCNNRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 08:17:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=s2jIfMximO9qbefmq8rsthtWS6YzmL8mdPNWWck1faOeXfqN/4s6oT3P/9mP3LDoWmaSkcxfnaW6iXyjHefL2oEaQEZZnUc7xAI8P3FqwmT1HijLaPda64JDjQR9DXmaVWHCD/RdhHb5zbfYobhVS4pYO/qUrNyF8fYON0IlgOA=
Message-ID: <2cd57c9005031405176c7dce2c@mail.gmail.com>
Date: Mon, 14 Mar 2005 21:17:03 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: hold task lock question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Should we hold some lock (like task_lock(tsk)) when test tsk->mm == &init_mm 
or any things else like tsk->mm ==0 ? Suppose it's the final test.

Thanks
	
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
