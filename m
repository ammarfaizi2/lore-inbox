Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278420AbRJSOGH>; Fri, 19 Oct 2001 10:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278421AbRJSOF4>; Fri, 19 Oct 2001 10:05:56 -0400
Received: from gw-nl4.philips.com ([212.153.190.6]:58117 "EHLO
	gw-nl4.philips.com") by vger.kernel.org with ESMTP
	id <S278420AbRJSOFq>; Fri, 19 Oct 2001 10:05:46 -0400
From: fabrizio.gennari@philips.com
Subject: Compilation fails if SERIAL_DEBUG_PCI is set
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Oct 2001 16:05:51 +0200
Message-ID: <OFBC87643B.976FB0A4-ONC1256AEA.004D3195@diamond.philips.com>
X-MIMETrack: Serialize by Router on hbg001soh/H/SERVER/PHILIPS(Release 5.0.5 |September
 22, 2000) at 19/10/2001 16:22:35
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.4.12, the file drivers/char/serial.c fails to compile if SERIAL_DEBUG_PCI is set (line 128). The compiler giver the error:

serial.c:4147 Structure has not a member subdevice

(or something like that).

---------------------------------------------------------
Fabrizio Gennari          tel. +39 039 203 7816
Philips Research Monza    fax  +39 039 203 7800
via G. Casati 23          fabrizio.gennari@philips.com
20052 Monza (MI) Italy    http://www.research.philips.com


