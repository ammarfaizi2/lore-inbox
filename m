Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270661AbRIJLVh>; Mon, 10 Sep 2001 07:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270585AbRIJLV0>; Mon, 10 Sep 2001 07:21:26 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:32481 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S270640AbRIJLVL>; Mon, 10 Sep 2001 07:21:11 -0400
Date: Mon, 10 Sep 2001 04:21:32 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.10-pre7/drivers/sound/i810_audio.c missing definitions
Message-ID: <20010910042132.A880@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.4.10-pre7/drivers/sound/i810_audio.c fails to compile,
because it or some .h file lacks definitions of the following symbols:

AC97_EA_PRI  
AC97_EA_PRJ  
AC97_EA_PRK  
AC97_EA_SLOT_MASK  
AC97_EA_SPDIF
AC97_EA_SPDIF  
AC97_EA_SPSA_3_4  
AC97_EA_VRA  
AC97_SC_SPSR_32K  
AC97_SC_SPSR_44K  
AC97_SC_SPSR_48K  
AC97_SC_SPSR_MASK  
AC97_SPDIF_CONTROL  

	This must be the result of an incomplete patch.


-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
