Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292325AbSCEX64>; Tue, 5 Mar 2002 18:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293676AbSCEX6r>; Tue, 5 Mar 2002 18:58:47 -0500
Received: from hera.cwi.nl ([192.16.191.8]:1153 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292325AbSCEX6h>;
	Tue, 5 Mar 2002 18:58:37 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 5 Mar 2002 23:58:34 GMT
Message-Id: <UTC200203052358.XAA187444.aeb@cwi.nl>
To: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: bitkeeper / IDE cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> fwiw, I prefer to not use bitkeeper, for the reasons which you outline.

Seconded.


Martin Dalecki writes:

: Disable configuration of the task file stuff.
: It is going to go away and will be replaced by a truly abstract interface

Comment #1: Please observe the difference between cleanup and development.
 I think your patches already went too far under the "cleanup" heading.

Comment #2: We need a nice, general interface for the usual things,
 and a very detailed direct-to-hardware interface for special purposes.
 [Change the behaviour of a zip drive from "big floppy" to "removable disk"
 and back. Take care of passwords on disks. Unstroke a 32+GB disk. Etc.]


Andries




