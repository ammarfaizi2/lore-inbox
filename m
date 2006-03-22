Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWCVP3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWCVP3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCVP3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:29:15 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:39700 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751324AbWCVP3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:29:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B72nrb6XHt4h2OmgxVRw8+ioOLnXQFuM6GHzgLLi3+cMGK1mmRNGUFvK/Z7946hPsY28ut+/EUoApfvhj4JZVVupTBQo80JzJT9Gq2y4Wn0Qy061Nrb0cTeIbzk/p68jvLeVoacVfkTkfrTO5V90g4rHUtc96s+fApv3ZS5LEGA=
Message-ID: <4ae3c140603220729t63be15bcm96151c59474bbb60@mail.gmail.com>
Date: Wed, 22 Mar 2006 10:29:13 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: question regarding to read memory in page fault handler
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to read the page content after the page fault handler load a
page. I know the memory address. Can I simply copy the data from that
address to my destination buffer using memcpy()? I tried, but there
must be somthing wrong, the result is not right. :(

Thanks in advance!
Xin
