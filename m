Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbTAPAee>; Wed, 15 Jan 2003 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTAPAed>; Wed, 15 Jan 2003 19:34:33 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:3009 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266939AbTAPAed>;
	Wed, 15 Jan 2003 19:34:33 -0500
Message-ID: <1042677806.3e26002e98f98@kolivas.net>
Date: Thu, 16 Jan 2003 11:43:26 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: $299.95 /mo  Max/Max  10 GB  $119 /GB  Charged
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cannot allocate memory : fork error with 2.5.5x 

MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Internet Messaging Program (IMP) 3.1



Since moving contest (http://contest.kolivas.net) to c I get an error trying to
fork with all 2.5 kernels I try after running it on the 6th load. The error does
not occur with any 2.4 kernels. I have confirmed it is still present on 2.5.58.

To reproduce the problem:
Run the latest version of contest without arguments (0.61pre) and after
no_load,cacherun,process_load,ctar_load,xtar_load and io_load it bombs out with:
bmark.c:43: SYSTEM ERROR: Cannot allocate memory : fork error

This is not an application error and does not occur with 2.4.x kernels. It
happens every time and with all 2.5 kernels I have tried. I can start contest
again without problems after each error and eventually will run into the same error.

Con
