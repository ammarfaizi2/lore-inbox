Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318299AbSHUOWi>; Wed, 21 Aug 2002 10:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSHUOWh>; Wed, 21 Aug 2002 10:22:37 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:14213 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318299AbSHUOWg>; Wed, 21 Aug 2002 10:22:36 -0400
Message-ID: <20020821142544.29460.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "sanket rathi" <sanket@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Aug 2002 22:25:44 +0800
Subject: Interrupt Handler
X-Originating-Ip: 202.54.40.40
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am writing a device driver for a pci card i know that whenever u r writing a interrupt handler there are some restrictions. like u cannot acquire a lock, u can't sleep but i want to know, is there some restriction like i can't use buffers which i have allocated through vmalloc. actually i allocated some structure through vmalloc in init_module() and referencing them in interrupt handler will that create some problem.

Thanks in advance

----Sanket
-------------
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
