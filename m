Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318123AbSGRRPJ>; Thu, 18 Jul 2002 13:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318278AbSGRRPJ>; Thu, 18 Jul 2002 13:15:09 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:25306 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318123AbSGRRPI>; Thu, 18 Jul 2002 13:15:08 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Kernel headers....ppp, 2.4, 2.5
Date: Wed, 17 Jul 2002 13:21:02 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207171321.02167.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
Having some trouble compiling kdenetwork.

/usr/include/linux/if_ppp.h:90: use of enum `NPmode' without previous 
   declaration

This is defined in ppp_defs.h, but apparently it doesn't get included 
anywhere...  

Should ppp_defs.h be included in if_ppp.h
(that goes for if_pppvar.h too) ?
I see those headers use structures from ppp_defs.h







