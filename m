Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSINMYG>; Sat, 14 Sep 2002 08:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSINMYG>; Sat, 14 Sep 2002 08:24:06 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:43215 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S315762AbSINMYE>; Sat, 14 Sep 2002 08:24:04 -0400
Message-ID: <20020914122519.12033.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org
Date: Sat, 14 Sep 2002 20:25:19 +0800
Subject: Re: System response benchmarks in performance patches
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,
I've just tried your benchmark against a vanilla 2.4.19 and 2.5.34 

Results:

_NO LOAD_
Kernel		Time		CPU
2.4.19		7:37.99		99%
2.5.34		7:47.68		99%

_IOLOAD_
Kernel		Time		CPU
2.4.19		11:23.86	65%
2.5.34		10:48.24	72%

_CPULOAD_
Kernel		Time		CPU
2.4.19		9:07.80		82%
2.5.34		8:50.56		87%

_MEMLOAD_ [Probably wrong with 2.5*]
Kernel		Time		CPU
2.4.19		10:00.63	78%
2.5.34		7:45.80		99%

Hope it helps.

Ciao,
         Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
