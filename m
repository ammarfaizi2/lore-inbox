Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUAQCv1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUAQCv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:51:27 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:45325 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S265961AbUAQCv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:51:26 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
Date: Sat, 17 Jan 2004 02:47:35 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bua7o7$ahj$1@abraham.cs.berkeley.edu>
References: <Xine.LNX.4.44.0401161039480.20623-100000@thoron.boston.redhat.com> <40081AF0.5060907@borgerding.net>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1074307655 10803 128.32.153.228 (17 Jan 2004 02:47:35 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 17 Jan 2004 02:47:35 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Borgerding  wrote:
>James Morris wrote:
>>Eli Biham has suggested encrypting the sector numbers, see
>>http://people.redhat.com/jmorris/crypto/cryptoloop_eli_biham.txt
>
>This does not defend against a dictionary attack.

Right.  It defends against a different attack.  It appears that
there may be multiple weaknesses here...
