Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284607AbRLPNTu>; Sun, 16 Dec 2001 08:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284608AbRLPNTk>; Sun, 16 Dec 2001 08:19:40 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:55819 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S284607AbRLPNT0>; Sun, 16 Dec 2001 08:19:26 -0500
Subject: Alpha  - how to fill the PC
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 16 Dec 2001 18:49:56 +0530
Message-Id: <1008508796.18634.8.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

 	I am trying to do  process migration between nodes  using alpha
architecture. For explaining what is happening I will take the process
getting migrated from node1 to node2. I am using struct pt_regs  for
rebuilding the process on  node2.I am getting the same  value of struct
pt_regs on node1 and on node2 ( I print is using dik_show_regs) Now I
want to set the value of registers including the program counter with
the value i got from node1. Right now I am doing
ret_from_sys_call(&regs). But then i am getting a Oops . The Oops
message contain all the register values same as that I got from node1
except pc and ra 

	Any idea where I went wrong ? 

 -aneesh 



