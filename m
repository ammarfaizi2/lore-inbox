Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289335AbSA3Py0>; Wed, 30 Jan 2002 10:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289334AbSA3PyQ>; Wed, 30 Jan 2002 10:54:16 -0500
Received: from ip68-4-176-16.oc.oc.cox.net ([68.4.176.16]:14220 "EHLO
	drc.dhs.org") by vger.kernel.org with ESMTP id <S289335AbSA3PyC> convert rfc822-to-8bit;
	Wed, 30 Jan 2002 10:54:02 -0500
Subject: Catching modifier keys after kernel boot
Date: Wed, 30 Jan 2002 07:53:57 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <BBD0383DC5A68543ABDBF429FE64B4200141FB@DILBERT.drc.dhs.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
Thread-Topic: Catching modifier keys after kernel boot
Thread-Index: AcGpplLxrJxHqrdwSB+myQxN56OiZQ==
From: "David Christensen" <dave@drc.dhs.org>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a system recovery mechanism that runs in the linuxrc file
that will restore a corrupted system.  I need to do it by detecting that
the user is pressing a certain key sequence (such as
CTRL-ALT-BACKSPACE).  Since the user may start pressing that key
sequence while the kernel is booting, how can I detect the make codes
for the CTRL and ALT keys?  (The BACKSPACE key is easy enough to see
since the keyboard in autorepeat mode repeats the last key pressed.)
I'm already reading from the keyboard in RAW mode, but is there another
way to check the state of the modifier keys?

David Christensen
