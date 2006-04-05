Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWDEM7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWDEM7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 08:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWDEM7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 08:59:39 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:61115 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id S1751225AbWDEM7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 08:59:38 -0400
Date: Wed, 5 Apr 2006 15:00:19 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: linux-kernel@vger.kernel.org
Subject: mpi application fails with vanilla 2.6 kernels, works with rhel
 kernels
Message-ID: <Pine.LNX.4.64.0604051450430.24394@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



         Hi all,

         I am trying to run WRF model (http://wrf-model.org) on a dual core 
dual cpu opteron system with intel c/fortran 9 , scientific linux (rhel compatible,
tried 3.0.4 ,3.0.5 , 4.2) and mpich 1.2.7p1. As long as I use the vendor supplied
kernels everything works fine.However , when I use kernels compiled on my own, I am
getting erratic behaviour: the model will either crash, or produce invalid results,
or complete successfully approximately once in 20 attemps. If I run it on one CPU
it completes successfully with all kernels.
         I have tried with 2.6.14.3, 2.6.15.6 and 2.6.9. Both show the same 
erratic behaviour. Kernels 2.6.9-22 and 2.6.9-34 as supplied by scientific 
linux 4.2 and 2.4.21-37.0.1 in 3.0.4 work fine. All kernels are smp enabled.
I am copying the .config of the vendor kernels, compiling mpt fusion scsi 
drivers in kernel and not as modules in some cases. The application runs 
exclusively on the opteron system.
 	I have no idea how to deal with this situation. Any help is 
appreciated.

 	Best regards,

--
============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle University of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
 	  http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : de2bd8f73d545f0e4caf3096894ad83f  pgp_public_key.asc
============================================================================
