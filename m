Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSGIOgC>; Tue, 9 Jul 2002 10:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSGIOgB>; Tue, 9 Jul 2002 10:36:01 -0400
Received: from 62-190-201-211.pdu.pipex.net ([62.190.201.211]:56328 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S315431AbSGIOf7>; Tue, 9 Jul 2002 10:35:59 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207091443.PAA02132@darkstar.example.net>
Subject: Re: Driverfs updates
To: wowbagger@sktc.net (David D. Hagood)
Date: Tue, 9 Jul 2002 15:43:30 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D2AD518.6090706@sktc.net> from "David D. Hagood" at Jul 09, 2002 07:20:40 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems to me the problem is in designing modules to unload, and saying 
> "Then don't unload them" is not even a band-aid - it is willful 
> ignorance. If there is a potential race condition unloading a module, 
> then the module is BROKEN.

Agreed.  Unloading is as fundamental as loading - especially as a lot of users load and unload modules as a, (bad), way to use two incompatible devices on one port.  Once you introude a bloatule (I.E. module that can't be unloaded), that stops working.  As more and more people start relying on the behavior, it gets to be more of a problem.

John.
