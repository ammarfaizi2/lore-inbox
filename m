Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbSJ3V3V>; Wed, 30 Oct 2002 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264941AbSJ3V3V>; Wed, 30 Oct 2002 16:29:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36623 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264933AbSJ3V3U>; Wed, 30 Oct 2002 16:29:20 -0500
Date: Wed, 30 Oct 2002 16:34:46 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Matthew J. Fanto" <mattf@mattjf.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: The Ext3sj Filesystem
In-Reply-To: <200210301434.17901.mattf@mattjf.com>
Message-ID: <Pine.LNX.3.96.1021030163049.14524A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Matthew J. Fanto wrote:

> 
> I am annoucing the development of the ext3sj filesystem. Ext3sj is a new 
> encrypted filesystem based off ext3. Ext3sj is an improvement over the 
> current loopback solution because we do not in fact require a loopback 
> device. Encryption/decryption is transparent to the user, so the only thing 
> they will need to know is their key, and how to mount a device. We do not 
> encrypt the entire volume under the same key as some solutions do (this can 
> not only aid in a known-plaintext attack, but it gives the users less 
> options). Instead, every file is encrypted seperately under the key of the 
> users choice. We are also adding support for reading keys off floppies, 
> cdroms, and USB keychain drives. Currently, ext3sj supports the following 
> algorithms: AES, 3DES, Twofish, Serpent, RC6, RC5, RC2, Blowfish, CAST-256, 
> XTea, Safer+, SHA1, SHA256, SHA384, SHA512, MD5, with more to come. 
> If anyone has any comments, questions, or would like to request an algorithm 
> be added, please let me know. 

Is this just an announcement of an interesting idea, or does the code
exist? I looked at www.mattjf.com found a buch of "not on this server"
links, and a bunch of useful doc files, but no mention of extsj.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

