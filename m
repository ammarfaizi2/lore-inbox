Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVJHDpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVJHDpR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 23:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVJHDpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 23:45:16 -0400
Received: from nproxy.gmail.com ([64.233.182.199]:58705 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932132AbVJHDpP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 23:45:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Aj8nW7yuCrqsoXkKL2khkv/u5RlsAYPmGeK/JNJI7zvS9S4I9AnDom6QMTEJk248qga6Vf+bsZt509IQPwpxqRJPJvD8mDXkIyxcvoj3qpC49iQESbCwV2QLrfCEoypARRd+dEJeCX7qNq3Sc7EsaVL+lEU8b/+tmSfPPUR4eaY=
Message-ID: <2cd57c900510072045m6949b621udfc9cf99a7708a75@mail.gmail.com>
Date: Sat, 8 Oct 2005 11:45:14 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [q] how to make sure a process is not on CPU?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to manipulate a process, I must make sure not only the
process won't go away under me, also it is not on CPU, and it'll
return from schedule() at lease once.

Any thoughts?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
