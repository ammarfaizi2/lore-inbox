Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136024AbRDVKny>; Sun, 22 Apr 2001 06:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136025AbRDVKnm>; Sun, 22 Apr 2001 06:43:42 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:15747 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S136024AbRDVKmY>; Sun, 22 Apr 2001 06:42:24 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: junio@siamese.dhis.twinsun.com
cc: Manuel McLure <manuel@mclure.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12 
In-Reply-To: Message from junio@siamese.dhis.twinsun.com 
   of "21 Apr 2001 23:07:28 PDT." <7vitjxcvrz.fsf@siamese.dhis.twinsun.com> 
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu> <20010421211722.C976@ulthar.internal.mclure.org>  <7vitjxcvrz.fsf@siamese.dhis.twinsun.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Apr 2001 11:42:09 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14rHJh-0005TP-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If gcc 2.96 uniformly implements it, I'd rather move this
>backward compatibility definition of __builtin_expect from
>include/asm-$(arch)/compiler.h to include/asm-generic/
>somewhere.

The feature isn't machine dependent, though I don't think all compilers that 
call themselves "gcc 2.96" support it.  It might be better to test for "2.97".

p.


