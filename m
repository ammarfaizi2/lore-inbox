Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270131AbRHNDOD>; Mon, 13 Aug 2001 23:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270018AbRHNDNy>; Mon, 13 Aug 2001 23:13:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61706 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266158AbRHNDNq>; Mon, 13 Aug 2001 23:13:46 -0400
Date: Mon, 13 Aug 2001 22:45:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.8: error on dasd.c 
Message-ID: <Pine.LNX.4.21.0108132243330.19368-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I got some errors while trying to compile stock 2.4.8 on S390:

dasd.c: In function `dasd_alloc_request':
dasd.c:1069: warning: unused variable `flags'
dasd.c:1068: warning: unused variable `i'
dasd.c: In function `dasd_default_erp_action':
dasd.c:1952: warning: assignment makes pointer from integer without a cast
dasd.c: In function `dasd_revalidate':
dasd.c:2151: warning: implicit declaration of function `dasd_destroy_partitions'
dasd.c: In function `dasd_disable_volume':
dasd.c:2660: warning: unused variable `part'
dasd.c: In function `dasd_state_del_to_new':
dasd.c:2954: warning: label `noidal' defined but not used
dasd.c: At top level:
dasd.c:3258: warning: `dasd_destroy_partitions' was declared implicitly `extern' and later `static'
dasd.c:2151: warning: previous declaration of `dasd_destroy_partitions'
dasd.c:3258: warning: type mismatch with previous implicit declaration
dasd.c:2151: warning: previous implicit declaration of `dasd_destroy_partitions'
dasd.c:3258: warning: `dasd_destroy_partitions' was previously implicitly declared to return `int'
dasd.c: In function `dasd_destroy_partitions':
dasd.c:3260: warning: unused variable `major'
dasd.c: In function `cleanup_dasd':
dasd.c:4048: warning: implicit declaration of function `list_for_each_safe'
dasd.c:4048: parse error before `{'
dasd.c:4017: warning: unused variable `range'
dasd.c: At top level:
dasd.c:4070: parse error before `&'
...

2.4.9-pre3 does not have any change to dasd.c 

