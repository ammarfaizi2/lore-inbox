Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270680AbTG0GIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 02:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270681AbTG0GIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 02:08:10 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:46095 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270680AbTG0GIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 02:08:09 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Date: Sun, 27 Jul 2003 10:23:13 +0400
User-Agent: KMail/1.5
Cc: margitsw@t-online.de (Margit Schubert-While)
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271023.15304.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Attached is patch against 2.6.0-test1 that adds type_name to all in-tree
>> sensors; it sets it to the same values as corr. 2.4 senors and (in one 
case)
>> changes client name to match that of 2.4.
>
> Well, it certainly doesn't with the lm85.c  :-)
> Hint - names are in lib/chips.h in sensors package :-)

It was my fault I should not start changing names, sorry. Sometimes this 
happens.

If this patch is accepted it is OK though, we may change other names to be 
more user-friendly as well.

-andrey

Please Cc me I am not on lkml


