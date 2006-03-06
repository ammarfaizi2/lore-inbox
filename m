Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752368AbWCFKbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbWCFKbm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 05:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbWCFKbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 05:31:42 -0500
Received: from delhi-203.197.196-2.vsnl.net.in ([203.197.196.2]:14218 "EHLO
	mail2.iitk.ac.in") by vger.kernel.org with ESMTP id S1751653AbWCFKbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 05:31:42 -0500
Date: Mon, 6 Mar 2006 16:01:33 +0530 (IST)
From: V Bhanu Chandra <vbhanu.lkml@gmail.com>
X-X-Sender: efs@vattikonda.junta.iitk.ac.in
To: linux-kernel@vger.kernel.org
Subject: [RFC] Encrypting file system
Message-ID: <Pine.LNX.4.64.0603061600540.16555@vattikonda.junta.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am thinking of designing and implementing a new native encrypting
file system for the linux kernel as a part of a student / research
project. Unlike dm-crypt/loop-AES/cryptoloop, I plan to target
slightly more ambitious user specifications such as: per-file random
secret encryption keys which are in-turn encrypted using the public
keys of all users having access to that filesystem object (a copy
each), and these "tokens" stored along with the file as meta-data (in
an extended attribute, for example).

I've already come up with an initial conceptualization / design for
this and have just begun with the implementation.

Any comments / guidance / suggestions are most welcome and solicitated.

It would be helpful if someone has implemented (or is working on) a
patch for the kernel that implements RSA in the CryptoAPI, else I
might have to resort to have a user-space service for key management
tasks.

Warm regards,
Bhanu

--
V Bhanu Chandra,
Undergraduate Student,
Department of Computer Science & Engg,
IIT Kanpur, India
