Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWD2ND7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWD2ND7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 09:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWD2ND7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 09:03:59 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:57479 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1750705AbWD2ND7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 09:03:59 -0400
Date: Sat, 29 Apr 2006 15:03:55 +0200
Message-Id: <1093777985@web.de>
MIME-Version: 1.0
From: devzero@web.de
To: linux-kernel@vger.kernel.org
Subject: =?iso-8859-15?Q?another_kconfig_target_for_building_monolithic_kernel_?=
 =?iso-8859-15?Q?(for_security)_=3F?=
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

i want to harden a linux system (dedicated root server on the internet) by recompiling the kernel without support for lkm (to prevent installation of lkm based rootkits etc)

since the "minimalistic" approach (removing complexity) is always a good strategy for security , it seems that it generally isn`t a trivial task to "strip down" the running kernel with xconfig/menuconfig, i.e. to turn the running kernel into an minimalistic monolithic version which "just fits" to the current hardware and contains the absolutely necessary. 

especially when you have no physical access to the machine, there is some danger that the system doesn`t boot and needs some operator resetting it and boot into working configuration again.

what i assume what could be needed is something like a build-target "make hardened-config-based-on-running-kernel" which does the following

- look at the running kernel which components/modules are loaded/used/active
- make  a .config based on that information (i.e. remove all unneded and turn this into monolithic version)
- probably tell the user what will be disabled in the monolitic kernel 

if this doesn`t sound too dumb (comments?) - maybe there is some sort of "receipe" or project how to do this in a more comfortable way (i.e. without working through the whole .config and without in-depth knowledge of all .config params) ?

regards
roland k.
systems engineer




_______________________________________________________________
SMS schreiben mit WEB.DE FreeMail - einfach, schnell und
kostenguenstig. Jetzt gleich testen! http://f.web.de/?mc=021192

