Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSICPEg>; Tue, 3 Sep 2002 11:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318784AbSICPEg>; Tue, 3 Sep 2002 11:04:36 -0400
Received: from 62-190-217-112.pdu.pipex.net ([62.190.217.112]:52488 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318783AbSICPEf>; Tue, 3 Sep 2002 11:04:35 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209031516.g83FGYhO003505@darkstar.example.net>
Subject: Re: [RFC] mount flag "direct"
To: ptb@it.uc3m.es
Date: Tue, 3 Sep 2002 16:16:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209031501.g83F1Oa31142@oboe.it.uc3m.es> from "Peter T. Breuer" at Sep 03, 2002 05:01:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Rationale:
> No caching means that each kernel doesn't go off with its own idea of
> what is on the disk in a file, at least. Dunno about directories and
> metadata.

Somewhat related to this - is there currently, or would it be possible to include in what you're working on now, a sane way for two or more machines to access a SCSI drive on a shared SCSI bus - in other words, several host adaptors in different machines are all connected to one SCSI bus, and can all access a single hard disk.  At the moment, you can only do this if all machines mount the disk read-only.

John.
