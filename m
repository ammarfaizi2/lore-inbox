Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbUE1ROO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUE1ROO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbUE1ROO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:14:14 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:4795 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261832AbUE1ROG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:14:06 -0400
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: 'uinput' Oops upon select() or poll() on 2.6.7-rc1
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 28 May 2004 19:13:59 +0200
Message-ID: <xb7ekp4cw4o.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When  I tried  to do  a select()  or poll()  on the  char  device that
'uinput' creates for  interacting with the input system,  I get a SEGV
in my userspace program.  'dmesg' shows an Oops message.

For details, please check the bugzilla entry

http://bugzilla.kernel.org/show_bug.cgi?id=2786



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

