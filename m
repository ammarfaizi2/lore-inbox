Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274669AbRJNHck>; Sun, 14 Oct 2001 03:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274666AbRJNHcb>; Sun, 14 Oct 2001 03:32:31 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:936 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S274683AbRJNHcO>; Sun, 14 Oct 2001 03:32:14 -0400
Message-ID: <3BC9401B.B746BA36@ameritech.net>
Date: Sun, 14 Oct 2001 02:34:51 -0500
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols 
 2.4.10-ac12/kernel/drivers/acpi/ospm/system/ospm_system.o
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.10-ac12;
fi

depmod: *** Unresolved symbols in
/lib/modules/2.4.10-ac12/kernel/drivers/acpi/o
spm/system/ospm_system.o

depmod:         acpi_ut_debug_print_raw
