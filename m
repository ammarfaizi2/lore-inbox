Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWEIUki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWEIUki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWEIUki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:40:38 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:39245 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751166AbWEIUkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:40:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fkqi8USkWhdMN5JHQpkk0cb2nQkoN/roPLuK1R8NvZ6tXNyxT1Esu6x1VjeSA7I18Lg1oT5tLErHlIeOpBS8A7oGr6+eJvPuRBegHW7blKj5Csm3xRwAhbxmzr8HjGSEkxwH4ais5ZSp/a6uL8g/FYOhUIC+xLVbIwSUzXqMVFQ=
Message-ID: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com>
Date: Tue, 9 May 2006 13:40:37 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Stability of 2.6.17-rc3?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was hoping 2.6.17 would be out within one week, doesn't look like it
is going to happen.
My thesis defense is coming up, need to merge my patches against some kernel
(requiring 2.6.16.1 looks weird).

On a machine that 2.6.16.1 runs bug-free, is it sane to assume
2.6.17-rc3 will as well?
If it fails outright, I can revert, but if it is unstable I'm going to
have some problems.
(You would be surprised how long it took me to discover a mistake that
sys_rename(on any filesystem) -> deadlock with my custom patch).
