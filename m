Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264074AbRFESxz>; Tue, 5 Jun 2001 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264075AbRFESxq>; Tue, 5 Jun 2001 14:53:46 -0400
Received: from comverse-in.com ([38.150.222.2]:20099 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S264074AbRFESxc>; Tue, 5 Jun 2001 14:53:32 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F24@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'David Gordon (LMC)'" <David.Gordon@ericsson.ca>
Cc: linux-kernel@vger.kernel.org
Subject: RE: kHTTPd hangs 2.4.5 boot when moduled
Date: Tue, 5 Jun 2001 14:52:33 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found that when kHTTPd is compiled as a module, kernel 
> 2.4.5 will hang 
...
> I run an Intel RH7.0 machine.

Please note the following discrepancy between RH70 and the minimal required
versions
of the following 3 packages (I am ommitting others, like pci or reiserfs
stuff, as these
seem irrelevant to your case. See Docu*/Changes on 2.4.5 for details)

package	RH7.0 has...	2.4.2 and on needs...
util-linux	2.10m		2.10o
modutils	2.3.21		2.4.2
e2fsprogs	1.18		1.19

HTH,
	Vassilii
