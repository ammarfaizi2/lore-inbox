Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSGROKU>; Thu, 18 Jul 2002 10:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318063AbSGROKU>; Thu, 18 Jul 2002 10:10:20 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:21194 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S318060AbSGROKT>; Thu, 18 Jul 2002 10:10:19 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bernd Schubert <bernd.schubert@tc.pci.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: stale nfs errors on proc
Date: Thu, 18 Jul 2002 16:13:17 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207181613.17319.bernd.schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sometimes we get stale nfs errors with proc files. Mostly this happens with 
sshd (remote ssh login is not possible in this case), on trying to kill the 
sshd server by killall -15 sshd, we get something like this (I have forgotten 
the exact syntax): stale nfs error on /proc/nn/EXE

A killall -9 sshd works fine.


Best Regards,

Bernd
