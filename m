Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbVEKRPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbVEKRPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVEKRPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:15:03 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:12464 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261993AbVEKROk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:14:40 -0400
Subject: Re: ioctl to keyboard device file.
From: Marcel Holtmann <marcel@holtmann.org>
To: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in>
Content-Type: text/plain
Date: Wed, 11 May 2005 19:14:11 +0200
Message-Id: <1115831651.23458.74.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>       I want to add a new ioctl to keyboard driver device file which will 
> perform the work of copying user space data  sent to it into kernel 
> space and send those characters  to handle_scancode function of keyboard 
> driver.. Now I want to know
> 
> 1) what is the device file corresponding to keyboard (is it 
> /dev/input/keyboard).
> 2) where file operations structure is defined for that.
> 3) where the those ioctls handled(not found in keyboard.c).
> 
> Any small help is appreciated.

why not using uinput for this job?

Regards

Marcel


