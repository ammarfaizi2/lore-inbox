Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWFLQot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWFLQot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbWFLQot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:44:49 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:54157 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751126AbWFLQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:44:48 -0400
Subject: bcm43xx in 2.6.17-rc6
From: Andreas Rittershofer <andreas@rittershofer.de>
Reply-To: andreas@rittershofer.de
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 12 Jun 2006 18:44:35 +0200
Message-Id: <1150130676.3820.26.camel@coredump>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-ID: ThqOe0ZUgeshomr5P90TcTmK1-xNlN4LwC+Hw-aTMv6Z0A4lY5UUgN@t-dialin.net
X-TOI-MSGID: 579b56d0-ef1b-48b7-897a-1a855af9aa0a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lspci says:

00:0c.0 Network controller: Broadcom Corporation BCM4303 802.11b
Wireless LAN Controller (rev 02)


So the bcm43xx-support with kernel 2.6.17-rc6 should work, but it does
only partially - WPA is not running; wpa_supplicant says:

ioctl[SIOCSIWENCODEEXT]: Invalid argument
Driver did not support SIOCSIWENCODEEXT
WPA: Failed to set PTK to the driver.
State: 4WAY_HANDSHAKE -> GROUP_HANDSHAKE
CTRL-EVENT-TERMINATING - signal 2 received
Removing interface eth1
State: GROUP_HANDSHAKE -> DISCONNECTED
wpa_driver_wext_deauthenticate
ioctl[SIOCSIWMLME]: Operation not supported
wpa_driver_wext_set_key: alg=0 key_idx=0 set_tx=0 seq_len=0 key_len=0
wpa_driver_wext_set_key: alg=0 key_idx=1 set_tx=0 seq_len=0 key_len=0
wpa_driver_wext_set_key: alg=0 key_idx=2 set_tx=0 seq_len=0 key_len=0
wpa_driver_wext_set_key: alg=0 key_idx=3 set_tx=0 seq_len=0 key_len=0
wpa_driver_wext_set_key: alg=0 key_idx=0 set_tx=0 seq_len=0 key_len=0
EAPOL: External notification - portEnabled=0
EAPOL: SUPP_PAE entering state DISCONNECTED
EAPOL: SUPP_BE entering state INITIALIZE
EAPOL: External notification - portValid=0
wpa_driver_wext_set_wpa
wpa_driver_wext_set_drop_unencrypted
wpa_driver_wext_set_countermeasures
No keys have been configured - skip key clearing


What is wrong here?

mfg ar

-- 
E-Learning in der Schule:
http://www.dbg-metzingen.de/Menschen/Lehrer/Q-T/Rittershofer/E-Learning/

