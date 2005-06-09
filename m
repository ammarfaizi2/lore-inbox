Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVFIXWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVFIXWh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 19:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFIXWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 19:22:37 -0400
Received: from smtp06.auna.com ([62.81.186.16]:30880 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262424AbVFIXTw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 19:19:52 -0400
Date: Thu, 09 Jun 2005 23:19:49 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Problems with usb and digital camera
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.3.3
Message-Id: <1118359189l.15128l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.85] Login:jamagallon@able.es Fecha:Fri, 10 Jun 2005 01:19:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have a Canon Powershot A70 and it used to work nicely with linux and
gnome. But now it has stopped working.

When I plug the camera, gthumb pops and try to import photos. But I get a
window with this message:

An error occurred in the io-library ('Error updating the port settings'): Could not set config 0/1 (Device or resource busy)

syslog shows this:

Jun  6 23:43:04 werewolf kernel: usb 5-2: new full speed USB device using uhci_hcd and address 6
Jun  6 23:45:38 werewolf kernel: usb 5-2: usbfs: interface 0 claimed by usbfs while 'gthumb' sets config #1

I have now 2.6.12-rc6-mm1. My USB pendrive works nicely.

Are you aware of any strange behaviour of USB in this kernel ?
What means the syslog message ? The kernel grabs the device to show in usbfs
and nobody can open it ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam23 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


