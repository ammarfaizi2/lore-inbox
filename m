Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264829AbSJ3T2E>; Wed, 30 Oct 2002 14:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264832AbSJ3T2E>; Wed, 30 Oct 2002 14:28:04 -0500
Received: from d196069.dynamic.cmich.edu ([141.209.196.69]:39313 "EHLO euclid")
	by vger.kernel.org with ESMTP id <S264829AbSJ3T2D> convert rfc822-to-8bit;
	Wed, 30 Oct 2002 14:28:03 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: "Matthew J. Fanto" <mattf@mattjf.com>
Reply-To: mattf@mattjf.com
Organization: mattjf.com
To: linux-kernel@vger.kernel.org
Subject: The Ext3sj Filesystem
Date: Wed, 30 Oct 2002 14:34:17 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210301434.17901.mattf@mattjf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am annoucing the development of the ext3sj filesystem. Ext3sj is a new 
encrypted filesystem based off ext3. Ext3sj is an improvement over the 
current loopback solution because we do not in fact require a loopback 
device. Encryption/decryption is transparent to the user, so the only thing 
they will need to know is their key, and how to mount a device. We do not 
encrypt the entire volume under the same key as some solutions do (this can 
not only aid in a known-plaintext attack, but it gives the users less 
options). Instead, every file is encrypted seperately under the key of the 
users choice. We are also adding support for reading keys off floppies, 
cdroms, and USB keychain drives. Currently, ext3sj supports the following 
algorithms: AES, 3DES, Twofish, Serpent, RC6, RC5, RC2, Blowfish, CAST-256, 
XTea, Safer+, SHA1, SHA256, SHA384, SHA512, MD5, with more to come. 
If anyone has any comments, questions, or would like to request an algorithm 
be added, please let me know. 

-Matthew J. Fanto
