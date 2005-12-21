Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVLUJ0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVLUJ0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 04:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbVLUJ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 04:26:19 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:25807 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932331AbVLUJ0T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 04:26:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m2gHleM+i3YEIqdV0ebyjT/J9ckK3zP0yu9rK0mIRUrQw6zxYUnleEjJogqkFGhpUT8x4y35aK2sy0XEiCRvwUjRpDtm05rU421wehU660tiTga2KxenMYOJOuauVNRxhCV2j32LPHe3GO02xhhwkAVjkOYNdMhFrLq+N1zdzA4=
Message-ID: <3fe1d240512210126r14c87a6bh@mail.gmail.com>
Date: Wed, 21 Dec 2005 17:26:18 +0800
From: Hua Feijun <hua.feijun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to stop thread group of a process?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to stop thread group of a process in user mode or kernel mode.

I found that we can send a signal SIGSTOP to the thread group leader
to implement that. But I don't want to use signal.

But I don't find any functions about it.

Could any one give me some suggestion.
Thank you.
