Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289754AbSBESv0>; Tue, 5 Feb 2002 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289761AbSBESvP>; Tue, 5 Feb 2002 13:51:15 -0500
Received: from [199.203.178.211] ([199.203.178.211]:38674 "EHLO
	exchange.store-age.com") by vger.kernel.org with ESMTP
	id <S289754AbSBESvD>; Tue, 5 Feb 2002 13:51:03 -0500
Message-ID: <BDE817654148D51189AC00306E063AAE054627@exchange.store-age.com>
From: Alexander Sandler <ASandler@store-age.com>
To: "'Philippe Troin'" <phil@fifi.org>
Cc: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: How to crash a system and take a dump?
Date: Tue, 5 Feb 2002 20:50:31 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="x-user-defined"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is too genious to be found right away ;)

> Simplier: insmod this module:
> 
> #include <linux/module.h>
> 
> int init_module()
> {
>    panic("Forcing panic");
> }
> 
> int cleanup_module()
> {
> }

Sasha.
